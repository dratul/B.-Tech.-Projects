%%%%%%%%%%%% A New and Improved LaTeX template for BIET thesis/synopsis - 2022 %%%%%%%%%%%%%%%%%
% the BIET Thesis guidelines.  
% geometry package.  The double/singlespacing is setup using
% setspace.  Figure captions are set using the hang option of
% caption2.  natbib is used to do the citation using an
% author-year format. I've made an BIET.bst file that formats 
% the references as per the BIET guidelines.
%
% To use this class do the following:
%  \documentclass[options]{bietthesis} 
%
% Options:
%
%   PhD, MS, MTech, DD or BTech -- generates the appropriate title page
%   and loads the report class.

%	Adding 'PrntForm' as additonal option to the class 
%	(like \documentclass[PhD,PrntForm]{bietthesis} ) 
%	will generate the pdf that can be printable 
%	(with chapters always starting on the right side and page
%	numbers corrected appropriately)
%
%   synopsis -- Generates the title page for the synopsis.  This also
%   loads the article class instead of the report.
%  
% Example:
%
% \documentclass[PhD,synopsis]{bietthesis}
% \documentclass[PhD,PrntForm]{bietthesis}
% \documentclass[MS]{bietthesis}
%
% IMPORTANT NOTICE:
% 
%   PLEASE DO NOT MESS WITH THE MARGINS AND GENERAL FORMATTING SETUP
%   IN THIS FILE UNLESS YOU ARE ABSOLUTELY SURE THAT THE FORMAT DOES NOT
%   MATCH WITH THE THESIS GUIDELINES.  FOR EXAMPLE, DO NOT CHANGE THE 
%   MARGINS AND SPACING JUST TO MAKE YOUR THESIS SMALLER OR LARGER!
% 
% Notes:
%
%   * I am using as much of the Thesis guidelines for the spacing
%     and margins as I can (Check the institute guidelines from academic website or thesis_format.pdf in this folder to see the rules of formating)
%   * This class will assume a4paper with 12pt fonts.
%   * I am no TeXpert so feel free to clean up the mess.
%
% New Features :
% 	- removed obsolete options (compat2, hypertex) and to work with Tex 2022
%	- added Dual Degree option for project report 
%		(can be edited to use it for any course based degree like M.Sc., M.A., M.B.A)
%	- added the option 'PrntForm' to produce thesis with the necessary blank pages for printing
%	- added clean.sh bash file (works with Linux systems which uses bash) to clean the latex files for a fresh compilation
%	- separation of main tex file from its chapter/sections (using \include{file} option) along with proper grouping and labeling of files for easier sorting and debugging
%		(A01_title, B01_abstract, C01_chap1, D01_app1 and E01_lop)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	- added sample pages for quotations, dedication, glossary, abbreviations and notation
%	- cleaned up few parts where page numbers aren't required (quotes/dedication pages)
%	- added 'tabular' method for glossary/notation/abbreviations to avoid text overflow in long phrases that results from the usage of 'tabbing'
%	- corrected and added sample content to certificate; useful for co-guides and sponsored candidates
%	- corrected and added the necessary headings for 'List of Publications' chapter at the end
%	- added the sample CV and Committee pages at the end
%
% 	- added opensource licensing to the file for unambiguity in free usage and distribution
%   - moved packages, commands, preamble and postamble of the thesis to 0_settings folder for simpler look
%   - fixed various bugs in BIET.bst and added doi/arxiv link support for references

%%%%%%%%%%%%%%%%%%%%     Licensing	  %%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This work is licensed under the Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0) License. 
%% To view a copy of this license, visit: https://creativecommons.org/licenses/by-nc/4.0/

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{bietthesis}[2022/04/20 Class for BIET Jhansi Dissertations]

\newif\if@PhD
\newif\if@MS
\newif\if@MTech
\newif\if@DD
\newif\if@MBA
\newif\if@MSc
\newif\if@BTech
\newif\if@Synopsis
\newif\if@PrntForm

\DeclareOption{PhD}{\@PhDtrue}
\DeclareOption{MS}{\@MStrue}
\DeclareOption{MTech}{\@MTechtrue}
\DeclareOption{DD}{\@DDtrue}
\DeclareOption{MBA}{\@MBAtrue}
\DeclareOption{MSc}{\@MSctrue}
\DeclareOption{BTech}{\@BTechtrue}
\DeclareOption{synopsis}{\@Synopsistrue}
\DeclareOption{PrntForm}{\@PrntFormtrue}
\ProcessOptions\relax

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Load the correct class.
\if@Synopsis
    \LoadClass[12pt,a4paper]{article}
\else
	\if@PrntForm
		\LoadClass[12pt,a4paper,twoside,openright]{report}
	\else
    	\LoadClass[12pt,a4paper]{report}
    \fi
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Geometry and page layout
\RequirePackage[a4paper,left=1.25in,right=1.25in,top=1in,bottom=0.67in,
nohead,includefoot,footskip=0.67in]{geometry}[2018/05/13]
%\RequirePackage[compat2,a4paper,left=1.5in,right=1in,top=1in,bottom=0.667in,
%                nohead]{geometry}[2002/07/08] %% compat2 is obsolete
\parskip 8pt
%\setlength{\footskip}{10pt}  % Added for page number adjustment without compat2

\renewcommand{\@pnumwidth}{2.5em}
%\renewcommand{\@tocrmarg}{2.5em}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Using setspace to do the single/double spacing.  Setspace also
%% makes all tables and figures have single spacing automatically.
\RequirePackage{setspace} 
\RequirePackage{atbeginend} % used to redefine the list environs
\setstretch{1.5}

\BeforeBegin{itemize}{\vspace*{-5ex}\begin{singlespace}}
\AfterEnd{itemize}{\end{singlespace}}

\BeforeBegin{enumerate}{\vspace*{-5ex}\begin{singlespace}}
\AfterEnd{enumerate}{\end{singlespace}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% The figure captioning is done correctly via the hang option.
%%\RequirePackage[hang]{caption2}  -> TeX generates error
\RequirePackage[hang]{caption}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Bibliography
% 
% natbib allows easy switching of citation style and using it along
% with the BIET.bst makes things perfect.
%\RequirePackage[authoryear,round]{natbib} 
\RequirePackage[numbers,square]{natbib} 
\bibliographystyle{IEEEtran}

\newcommand{\bibstyle@BIET}{\bibpunct{(}{)}{;}{a}{,}{,}%
     \gdef\NAT@biblabel##1{##1. }}
%
\setlength{\bibhang}{0pt}
\citestyle{IEEEtran}
%\citestyle{unsrt_newen}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Other useful macros.  Many of these are modifications from newdiss.cls

% \department{department name} -- user macro to declare name of department.
\def\department#1{\gdef\@department{#1}}
\def\guide#1{\gdef\@guide{#1}}
%\RequirePackage[dvips]{graphicx}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The title page

\def\maketitle{%
  \pagenumbering{roman}
  \thispagestyle{empty}
  \newpage
  \null
  \setcounter{page}{1}
  \parskip=0pt
  \begin{center}%
  \let \footnote \thanks
  \vglue 0in % this makes top margin 2in
  \vskip -5ex%
  \if@Synopsis
    {\large \em SYNOPSIS OF \par}
  \fi
    {}%
    \vskip 10ex%
    {\normalsize
      \if@PhD
         {\em A THESIS }\par
         \vskip 5ex%
         \if@Synopsis
            {\normalsize \em to be submitted by \par}
         \else
            {\normalsize \em submitted by \par}
         \fi
         \vskip 5ex%
         {\bf \large\MakeUppercase{\@author}\par\par}
         \vskip 5ex%
         {\em for the award of the degree }\par
         \vskip 5ex%
         {\em of} \par
         \vskip 5ex%
         {\bf \large \MakeUppercase{Doctor of Philosophy}} \par
       \else
         \if@MS
            {\em A THESIS }\par
            \vskip 5ex%
            {\normalsize \em submitted by \par}
            \vskip 5ex%
            {\bf \large\MakeUppercase{\@author}\par\par}
            \vskip 5ex%
            {\em for the award of the degree }\par
            \vskip 5ex%
            {\em of} \par
            \vskip 5ex%
            {\bf \large \MakeUppercase{Master of Science}} \par
            (by Research) \par
       \else
       	 \if@DD
       		{\em A Project Report }\par
       		\vskip 1ex%
       		{\normalsize \em submitted by \par}
       		\vskip 1ex%
       		{\bf \large\MakeUppercase{\@author}\par\par}
       		\vskip 2ex%
       		{\normalsize \em under the guidance of \par}
       		{\bf \large\MakeUppercase{\@guide}\par\par}
       		\vskip 1ex%
       		{\normalsize \em in partial fulfilment of the requirements\par
       			for the award of the \par}
       		\vskip 1ex%
       		{\bf \large \MakeUppercase{Dual Degree}} \par
       		(B.Tech. and M.Tech.) \par
		% Uncomment below lines for specialization
                \vskip 1ex%
                {\normalsize \em with specialization in \par}
		\vskip 1ex%
		{\bf \normalsize \MakeUppercase{Applied Mechanics with Biomedical Engineeering}\par\par}
       	\else
           {\em A Project Report on }\par
		   {\Large \bf \expandafter{\@title} \par}%
           \vskip 2ex%
           {\normalsize \em submitted by \par}
           \vskip 2ex%
           {\bf \large\MakeUppercase{\@author}\par\par}
           \vskip 2ex%
           {\normalsize \em under the guidance of \par}
           \vskip 2ex%
           {\bf \large\MakeUppercase{\@guide}\par\par}
           \vskip 2ex%
           {\normalsize \em in partial fulfilment of the requirements\par
             for the award of the degree of \par}
           \vskip 2ex%
           \if@MTech
              {\bf \large \MakeUppercase{Master of Technology}}
           \fi
           \if@MBA
           	  {\bf \large \MakeUppercase{Master of Business Administration}} \par
           \fi
           \if@MSc
              {\bf \large \MakeUppercase{Master of Science}} \par
           \fi
           \if@BTech
              {\bf \large \MakeUppercase{Bachelor of Technology}}
           \fi
          \fi
         \fi
      \fi
    }
  \end{center}%

  \vspace*{0.2in}
  %\centerline{\psfig{figure=emblem.ps}}
%  \centerline{\includegraphics{BIETlogo.eps}}
%  \centerline{\includegraphics[scale=1.]{BIET}}
  \centerline{\includegraphics[width=3.8cm]{BIETlogo}}
  \vspace*{-0.15in}
  \begin{center}
    {\bf \large DEPARTMENT OF \@department\par}
    {\bf \large BUNDELKHAND INSTITUTE OF ENGINEERING AND TECHNOLOGY, JHANSI, INDIA}
    \vglue 0.50em
    {\bf \large \@date}\par
  \end{center}
  \parskip 8pt

}

\def\titlepage{\newpage\thispagestyle{empty}\c@page\z@}
\def\endtitlepage{\newpage}

\if@Synopsis
  \renewcommand\refname{REFERENCES}
\else
  % QUOTATIONS
  %
  \def\quotations{\chapter*{\centerline{QUOTATIONS}}
  	 \thispagestyle{empty}
  \addcontentsline{toc}{chapter}{QUOTATIONS}
  }

   % DEDICATION
   %
   \def\dedication{\chapter*{\centerline{DEDICATION}}
   	 \thispagestyle{empty}
   %\addcontentsline{toc}{chapter}{DEDICATION}
   }

   % CERTIFICATE
   %
   %   - this produces a certificate page as per BIET Regulations
   %     comment the following lines out to get it working.
   %
   \if@PhD
   \def\certificate{\chapter*{\centerline{THESIS CERTIFICATE}}%% A preliminary chapter
     %\vspace*{36pt}
     %\centerline{\Large \bf THESIS CERTIFICATE}
     \vskip 15pt
     \thispagestyle{empty}
     %\typeout{Certificate}
     %\setcounter{page}{-1}
   }
   \else
   \if@MS
	\def\certificate{\chapter*{\centerline{THESIS CERTIFICATE}}%% A preliminary chapter
	\vskip 15pt
	\thispagestyle{empty}
	}
   \else
   \def\certificate{\chapter*{\centerline{CERTIFICATE}}%% A preliminary chapter
	\vskip 15pt
	\thispagestyle{empty}
	}
	\fi
	\fi


   % % ACKNOWLEDGEMENTS
   % %
   % \def\acknowledgements{\chapter*{\centerline{ACKNOWLEDGEMENTS}
   %   \addcontentsline{toc}{chapter}{ACKNOWLEDGEMENTS}
   %   \setcounter{page}{1}
   % }

   
   % % Project outcomes
   % %   - this produces pages suitable for an BIET Abstract
   % \def\projectoutcomes\chapter*{\centerline{PROJECT OUTCOMES}}
   % \addcontentsline{toc}{chapter}{PROJECT OUTCOMES}
   % }
   % Program outcomes
   %   - this produces pages suitable 
   \def\programoutcomes\chapter*{\centerline{PROGRAM OUTCOMES}
   \addcontentsline{toc}{chapter}{PROGRAM OUTCOMES}
   }
% ABSTRACT
   %   - this produces pages suitable for 
   \def\abstract{\chapter*{\centerline{ABSTRACT}}
   \addcontentsline{toc}{chapter}{ABSTRACT}
   }
   % ACKNOWLEDGEMENT
   %   - this produces pages suitable for a BIET report
   \def\ack{\chapter*{\centerline{ACKNOWLEDGEMENT}}
   \addcontentsline{toc}{chapter}{ACKNOWLEDGEMENT}
   }
   % GLOSSARY
   %
   \def\glossary{\chapter*{\centerline{GLOSSARY}}
   \addcontentsline{toc}{chapter}{GLOSSARY}
   }

   % ABBREVIATIONS
   %
   \def\abbreviations{\chapter*{\centerline{ABBREVIATIONS}}
   \addcontentsline{toc}{chapter}{ABBREVIATIONS}
   }

   % NOTATION
	%
	\def\notation{\chapter*{\centerline{NOTATION}}
	\addcontentsline{toc}{chapter}{NOTATION}
	}

   % Use the nomencl package for the NOTATION section.

   % Makes the chapter heading
   \def\@makechapterhead#1{%
     {\parindent \z@ \raggedright \normalfont
       \ifnum \c@secnumdepth >\m@ne
       \begin{center}
         \Large\bfseries \@chapapp\space \thechapter
       \end{center}
       \par\nobreak
       \vskip 10\p@
       \fi
       \interlinepenalty\@M
       \Large \bf
       \begin{center}
         #1\par\nobreak      
       \end{center}
       \vskip 10\p@
       \thispagestyle{empty}
     }}

   % Makes the chapter heading for \chapter* commands
   \def\@makeschapterhead#1{%
     \vspace*{15\p@}%
     {\parindent \z@ \raggedright
       \normalfont
       \interlinepenalty\@M
       \Large \bfseries #1\par\nobreak
       \vskip 10\p@
     }}


   %LIST OF PAPERS
   \def\listofpapers{
           \normalbaselines
           \chapter*{\centerline{LIST OF PUBLICATIONS}}
           \markboth{LIST OF PUBLICATIONS}{LIST OF PUBLICATIONS}
           \addcontentsline{toc}{chapter}{LIST OF PUBLICATIONS}
   }

   
   % CV
   \def\CV{\chapter*{\centerline{CURRICULUM VITAE}}}

   % Comittee
   \if@PhD
       \def\committee{\chapter*{\centerline{DOCTORAL COMMITTEE}}}
   \else
       \if@MS
          \def\committee{\chapter*{\centerline{GENERAL TEST COMMITTEE}}}
        \fi
   \fi


   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   % Renewed commands to set the titles of various pages correctly.
   \renewcommand\contentsname{\centering TABLE OF CONTENTS}
   \renewcommand\listfigurename{\centering LIST OF FIGURES}
   \renewcommand\listtablename{\centering LIST OF TABLES}
   \renewcommand{\chaptername}{CHAPTER}
   

   \renewcommand\appendixname{APPENDIX}
%   \renewcommand\bibname{\centering REFERENCES}
   \renewcommand{\fnum@figure}{Fig. \thefigure}
\fi


