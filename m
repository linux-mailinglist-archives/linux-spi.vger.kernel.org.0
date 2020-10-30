Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4C22A0647
	for <lists+linux-spi@lfdr.de>; Fri, 30 Oct 2020 14:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgJ3NO3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 30 Oct 2020 09:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgJ3NO2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 30 Oct 2020 09:14:28 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9FDC0613CF;
        Fri, 30 Oct 2020 06:14:28 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id k9so6619514edo.5;
        Fri, 30 Oct 2020 06:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tVtMKb1/Ns2KdR9wgnCWQzkjQV5gMTlyJ4oarHSu3XQ=;
        b=OqRyn9GhB7MxQpK5CaKDCDprdI0XNg6Px+5ubATHsBknwygjkBbPvvIy6aj14DRWy0
         2M1BXu/ap1wejp7MWSkegQetc4YZ7P0BuosfsY/tAGbxAk8KMQoCUvOK0tMQwB2OjPHp
         dvKY/BXzTkEKb+RXwQ38ygILutM3iDrr+7/W8DTphOpmIrOYskLELwb8FwombPjNGuLq
         K2YG5gBsX0US1TcX7dsUs2DzUGqv/Bn2jozAn0zMe4ovW6RMplEr8oOwpv2KtlvxoTBr
         DFY5euO/zN6CDMhcbbZK3E6jh/PWngyqvTEp6+jxr5qfNxGDzV8rlhJsuVhPqBY1uULd
         kDRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tVtMKb1/Ns2KdR9wgnCWQzkjQV5gMTlyJ4oarHSu3XQ=;
        b=fKPYoavXXaFwOGa4fcg9lDpVcsWsQIiXWZ5mR8w1TfSSDHOQfWYykup9KTYwuv7FWU
         rkd/QiGQDsn6gIfKAnd5Jzs+tSgu2hmUTGegH9QqUsuf0AwnIGcUkVWgGOMWeX0rnMsb
         7/P29PZT2XlLWplv7U+5QV8LF+LUvANAG15kTP9gf+QlGO8NJz1/5uAjvEe590/H6xi/
         LN5OcMKF1+3fQLWUUYB1eRtTOoUGtSTsDU/GdF3fApKPNqZDhYcn6oeWQptlEhJQ6Y50
         E5BN1WeQ+J5Qfo2/M6GIvdpFfdArFFci0l9ZRvtb89RbSNECFgBNpsGS1LWDHXCTShbx
         1Cpw==
X-Gm-Message-State: AOAM533QlDoGFm0i3PGnatgEI2nJ02t3qquf0N0VUBuWHSccjR9KSReh
        tCoVX1TWFRYRdaFTF8jgbp0=
X-Google-Smtp-Source: ABdhPJxsdTFZvDmRzsiww8X4ohSEu/AkyUMo1Mm6VhYgi6YI8QT+LoJfXufXgQjHG1fbqYvvGfaVjA==
X-Received: by 2002:a05:6402:392:: with SMTP id o18mr2306046edv.283.1604063667101;
        Fri, 30 Oct 2020 06:14:27 -0700 (PDT)
Received: from skbuf ([188.25.2.177])
        by smtp.gmail.com with ESMTPSA id ce13sm3162500edb.32.2020.10.30.06.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 06:14:26 -0700 (PDT)
Date:   Fri, 30 Oct 2020 15:14:25 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Qiang Zhao <qiang.zhao@nxp.com>
Cc:     "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: fsl-dspi: fix NULL pointer dereference
Message-ID: <20201030131425.b2c3t3n4v6i67yfv@skbuf>
References: <20201029084035.19604-1-qiang.zhao@nxp.com>
 <20201029110319.iyvfmrlq6uz2pl2e@skbuf>
 <VE1PR04MB676878E41EB6E44B325A9C3A91150@VE1PR04MB6768.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VE1PR04MB676878E41EB6E44B325A9C3A91150@VE1PR04MB6768.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Oct 30, 2020 at 02:04:06AM +0000, Qiang Zhao wrote:
> I saw the patch, it just fix the issue when the kernel are booted up.
> But there still have the issue when the driver suspend and resume. 

I see, sorry, I only paid attention to the commit message since it
wasn't explicit that it is about the suspend/resume case. Let me look
closer at the patch.
