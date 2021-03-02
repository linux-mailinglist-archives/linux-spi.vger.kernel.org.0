Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58B1D32B4F9
	for <lists+linux-spi@lfdr.de>; Wed,  3 Mar 2021 06:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237341AbhCCFrd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 3 Mar 2021 00:47:33 -0500
Received: from mga04.intel.com ([192.55.52.120]:35710 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1573782AbhCBPNv (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 2 Mar 2021 10:13:51 -0500
IronPort-SDR: dx9XuLqeK0TtJoDiLJifNnIPaVDclBrDoFlaWuBB7L3eKz7a29HPFGQghJ/I37DU53x7jUUYYU
 VhYAedcdG7nQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="184407291"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="184407291"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 07:06:31 -0800
IronPort-SDR: nCZf4m0fIcNr0lM3tYhWS5qUqhcVPJbY5hXtRObSvBZyV1EgQh4U3EudaNnCLQf3LQxJj2YovM
 aWcs6f+N8SLw==
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="399055993"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 07:06:29 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lH6bT-009PhQ-87; Tue, 02 Mar 2021 17:06:27 +0200
Date:   Tue, 2 Mar 2021 17:06:27 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] parport: Introduce module_parport_driver() helper
 macro
Message-ID: <YD5Uc7j2MAFbFWZ3@smile.fi.intel.com>
References: <20210216110741.1286-1-andriy.shevchenko@linux.intel.com>
 <YDkpzZ8jL7O9HJuG@smile.fi.intel.com>
 <YDwmznD58ZtOwHgb@debian>
 <YDzaC2ahcHCrCI8V@smile.fi.intel.com>
 <CADVatmP7V+pbpUC4xV+BmNzbfudPE5S0tT-6CgUKbQrC-FMrBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADVatmP7V+pbpUC4xV+BmNzbfudPE5S0tT-6CgUKbQrC-FMrBA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Mar 02, 2021 at 02:51:45PM +0000, Sudip Mukherjee wrote:
> On Mon, Mar 1, 2021 at 12:12 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Sun, Feb 28, 2021 at 11:27:10PM +0000, Sudip Mukherjee wrote:
> > > On Fri, Feb 26, 2021 at 07:03:09PM +0200, Andy Shevchenko wrote:
> > > > On Tue, Feb 16, 2021 at 01:07:39PM +0200, Andy Shevchenko wrote:
> > > > > Introduce module_parport_driver() helper macro to reduce boilerplate
> > > > > in the existing and new code.
> > > >
> > > > Sudip, any comments on this?
> > >
> > > Sorry for the delay in reply.
> > > lgtm. I think there are few more drivers which can also use this new helper.
> > > Will you like to do them also?
> >
> > Yes, that's the (slow going) plan.
> >
> > > Acked-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> >
> > Thanks! I considered that you take it thru parport tree. Do you have something
> > else in mind?
> 
> I dont have a separate parport tree (parport is not under active
> development to have a separate tree). I send everything parport
> related to Greg and then he adds it to his tree.

MAINTAINERS doesn't show this. But good to know.

> I guess in this case if Greg agrees it can go via Mark's tree as the
> series will also have SPI related patches.

Okay, if Greg wants to handle this himself, I think I have to resend (he wasn't
in the Cc list). Otherwise Mark can also apply this if Greg is okay (but sounds
like I have to resend anyway to let him understand what's going on here).

-- 
With Best Regards,
Andy Shevchenko


