Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E8A327533
	for <lists+linux-spi@lfdr.de>; Mon,  1 Mar 2021 00:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbhB1X1y (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 28 Feb 2021 18:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbhB1X1y (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 28 Feb 2021 18:27:54 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BA1C06174A;
        Sun, 28 Feb 2021 15:27:14 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id m1so12728353wml.2;
        Sun, 28 Feb 2021 15:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bAUK5Ub24hCOkuchEu83wIQAds7fALIxopORMRod5gU=;
        b=F0LDRr25nrSx0ivF2bI9DUpj/6PQIaMEGasyY5pL/z7rpRYlXSShbDmozJ2H5zgw5d
         OEZ7OyF56nnPR4MhkDX+6KR/3pTa/Df3E2BwNQptL1Vfh4VMc3Pqgt7TnC1Vl7KcTdgo
         1XiZGbMVTJ05M+/3fUQC569GZ1YP01Ae34o58qSUMYRGMpJcJKJA9vXJy3D2I8LjVEE1
         Oq9Nn+XuThfuR5i6XJuz4+F/ZMyvhLpSUkNrEdyfJsowqPYi/MWIaWRGqXVGW5utWUKF
         xMRVJ2R9l58By57JKqao1MbzJkvMEE35Jp24CyeXKWI8tC3u9haj+WyqdHGU5Mxdk4Ef
         zOEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bAUK5Ub24hCOkuchEu83wIQAds7fALIxopORMRod5gU=;
        b=ixjM2p25XkD/hUw2MPkFI+gIAGFLp2UjqclfTDY+yAEseB58EEaYmFkFaGZ5CNL2y9
         Y8x0bPVn0ttdNONU1RrrUPYqmxGUWV2OXwZCZi3aLsujZNYbdl5UOG3SxrXQYKLEvyMn
         YBjSfqN0WGjX26EOJkxTzpeKRLTI8Fgj1nMYzBlZQNNLa9UZs7GBe2a8WU4RS4N5868v
         si2KQwXD2DmOukHF+RYiq/OrXa7/ypt3k4KEFiusGHDu/+fe/o3V/zEbaJt+QBpUrlDO
         zczGNBE1S8bjvPaA2564VqBPASwaaAdybIxFZMFkGDVPBsaL7RcS/X45UhvnBHfB8IfS
         EgkQ==
X-Gm-Message-State: AOAM530s3xsZR55evDr1rlR9Du8wNdWpSTQdTrdvCjMrfapoDFW+SHJS
        B2G4PLUX5A4XDwFBaDsgQHs=
X-Google-Smtp-Source: ABdhPJzrBV411B318HbiRHYa1BG3y73Zk828lla2ezOe0EU4NYQkk1ZW7GnnqG0mxwI0lrw0AN1Tww==
X-Received: by 2002:a05:600c:4f94:: with SMTP id n20mr12968298wmq.78.1614554832900;
        Sun, 28 Feb 2021 15:27:12 -0800 (PST)
Received: from debian (host-2-98-59-96.as13285.net. [2.98.59.96])
        by smtp.gmail.com with ESMTPSA id k4sm28639058wrd.9.2021.02.28.15.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 15:27:12 -0800 (PST)
Date:   Sun, 28 Feb 2021 23:27:10 +0000
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] parport: Introduce module_parport_driver() helper
 macro
Message-ID: <YDwmznD58ZtOwHgb@debian>
References: <20210216110741.1286-1-andriy.shevchenko@linux.intel.com>
 <YDkpzZ8jL7O9HJuG@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDkpzZ8jL7O9HJuG@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Andy,

On Fri, Feb 26, 2021 at 07:03:09PM +0200, Andy Shevchenko wrote:
> On Tue, Feb 16, 2021 at 01:07:39PM +0200, Andy Shevchenko wrote:
> > Introduce module_parport_driver() helper macro to reduce boilerplate
> > in the existing and new code.
> 
> Sudip, any comments on this?

Sorry for the delay in reply.
lgtm. I think there are few more drivers which can also use this new helper.
Will you like to do them also?

Acked-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>


--
Regards
Sudip
