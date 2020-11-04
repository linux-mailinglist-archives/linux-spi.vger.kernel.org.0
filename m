Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 970672A5B16
	for <lists+linux-spi@lfdr.de>; Wed,  4 Nov 2020 01:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbgKDAkT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Nov 2020 19:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgKDAkT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 3 Nov 2020 19:40:19 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80285C061A4B;
        Tue,  3 Nov 2020 16:40:18 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id w13so13668454eju.13;
        Tue, 03 Nov 2020 16:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fHY3vdUl02HFmgjopDfIPsTDOudo77Qk3qlLxz6Bz8c=;
        b=adOBIz9TTQqWZdrrtyI1SwaaykgICxV5FQoeQVZdDbsYNuvV7vwQuQH0GnFHT7VKCu
         vQcmutbiuNROmncLnWSrVUJMYCj0NPpbsBAn3b3ZmkD+4AFRxiOVBDy3XSFA7rlo4sGo
         nklMZZN3pZHfp4bL9sMJ1BQ8ER6ie7DGKrahRZvKE9EtIvWvgM7BuivFOFnPIwwqYol5
         J6AEtejIVUqMJGJ6q482pnJ/zwuPwFxHxgVqkGaZHfgZ5TA5JFqeQ3QMfgiz/rC8nEqe
         +IPNjaqhM7oODcNxVuvq133as8+8Y+5qYfBuDUSwI/U/vQeQJD9VqPMCdvcDU1/FmH6k
         IDTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fHY3vdUl02HFmgjopDfIPsTDOudo77Qk3qlLxz6Bz8c=;
        b=c2gnOA0Ulj4Lh4TFXioQ8eRO8fY6AGUhWcxaxv4M+kOeiIKBqFx5+a7lZy4wFWgMuW
         aNbwwNCTVr4C/+Xt9Ht6s00zaCmHFpvjK1tqEa4LpiA9P2zyDB67AX+yxHHjL1ZowYQV
         TAI2zyIvoQIqFW4tlM2kKr5sx/vTCJ2Wsri0XE4yo79F7EFs0KNKPyxFiD+rNTUbtIac
         /ZgjrM5Skchcad86puzJGC54uQQab3XU4PtBIFtIst6qnjzAQAi04yEL2XGQSci8y7yh
         qLG1KqJf0y/P82wI3QQ2RS8IXujbJ59Oo6ocgMBcGonUw2O4IEcmjjYkF2sAHlz/qgQY
         FvNg==
X-Gm-Message-State: AOAM531/YBtc07E1zL2t+gNP33N5Su9owVBAYd2ZZTFopaRzrXEu4W1T
        LYS3yitzZqm0RKCRGmPf6LA=
X-Google-Smtp-Source: ABdhPJzQmyU2LIelnG4pgJppgbbnsdwItsONEriaIsDFp4tq25FQcLpYs9h9iS6P866TQ6Fk8xi89w==
X-Received: by 2002:a17:906:16ca:: with SMTP id t10mr23774729ejd.24.1604450417272;
        Tue, 03 Nov 2020 16:40:17 -0800 (PST)
Received: from skbuf ([188.25.2.177])
        by smtp.gmail.com with ESMTPSA id mj17sm122652ejb.59.2020.11.03.16.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 16:40:16 -0800 (PST)
Date:   Wed, 4 Nov 2020 02:40:15 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Qiang Zhao <qiang.zhao@nxp.com>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Patch v2] spi: fsl-dspi: fix wrong pointer in suspend/resume
Message-ID: <20201104004015.k7mggfzm4rhfamkz@skbuf>
References: <20201103020546.1822-1-qiang.zhao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103020546.1822-1-qiang.zhao@nxp.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Nov 03, 2020 at 10:05:46AM +0800, Qiang Zhao wrote:
> From: Zhao Qiang <qiang.zhao@nxp.com>
> 
> Since commit 530b5affc675 ("spi: fsl-dspi: fix use-after-free in
> remove path"), this driver causes a "NULL pointer dereference"
> in dspi_suspend/resume.
> This is because since this commit, the drivers private data point to
> "dspi" instead of "ctlr", the codes in suspend and resume func were
> not modified correspondly.
> 
> Fixes: 530b5affc675 ("spi: fsl-dspi: fix use-after-free in remove path")
> Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
