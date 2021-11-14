Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F74344FB39
	for <lists+linux-spi@lfdr.de>; Sun, 14 Nov 2021 20:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236268AbhKNTrY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 14 Nov 2021 14:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236686AbhKNTqC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 14 Nov 2021 14:46:02 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43ADEC06120D;
        Sun, 14 Nov 2021 11:39:57 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id y12so5557509eda.12;
        Sun, 14 Nov 2021 11:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sxMkFaEX//vf07C1ORSRzv+G7Mr5HhcXd7Dvy6uf9Os=;
        b=XYzPxsVmxkma2/7zQFs6pkogo9GOC9YykE8KM4jA0WU7pD+AVX3CCiX/At3kTq+mLN
         yTUlfiA7FTLkjUFFfr/EHPVg6Ox/36lE/V72+EGaH+sfeqYez4Blc4xfBW4Ed/kVTC1S
         gk4gZwSoS4Jy2PKna4eQgsYKcne4dVay/7LAs3Mpv1ylqRvCEIFKHIqXeYdHPv4jcSy/
         11UbmUKjUUCEbIleYTVUM4q8lLHIl2NfhLn9hDuL6JZYD7lseXR5ZUXJCd9t1eeVWhJL
         F40yztetltG4VpGOA/UMZeIO6afZtCk50fIZ+FjAIKWo3cv56nkw/08d1oDdxsdcobl4
         jnYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sxMkFaEX//vf07C1ORSRzv+G7Mr5HhcXd7Dvy6uf9Os=;
        b=rA6cHiDdHq8nwLiysOpLmLngBFSHsXY48kT1LlsLVysGO080d5OrqUsiO+cKy0zSHQ
         zo16AfvTCIOR+GDWSK0IM0veYjJT3yeH6kI5itT05DKfjoiXtlZknWyEbJtVVGgO6qXL
         iQ4KRQaXS9gvn1KGkgmMi02M9mYKKAXZQeGpAyqbvdZSRAq/5OUurTsfez/KiUtxNl+j
         2TDBLXswW+K59SncpDAyhBBwFLvJ/uutfszs3os8S9a1hcVmeANZmkj8J2VpB9tIxHWT
         pEweZoX6z/xGH1fJtjtNn6P8vywTP0TIRSUw9BcLKg3k5MzOZbLRm5XaqqOxGyia71Ja
         X9aA==
X-Gm-Message-State: AOAM530PmPYdrd/2cIfwb4LKxVMtSa7J9Igqx7/HyN3NvZPRQAzfbp+x
        JDlVU7x97vSXMyTFlFGZoIQ=
X-Google-Smtp-Source: ABdhPJyalmK0qvwZirNs2LEGCoHQeh4rortxfocYA7udYFUrdIcshl0e6Rl6J7Cu5ipoHLQ6BlKsyA==
X-Received: by 2002:a17:907:2cc3:: with SMTP id hg3mr42402417ejc.452.1636918795786;
        Sun, 14 Nov 2021 11:39:55 -0800 (PST)
Received: from skbuf ([188.25.175.102])
        by smtp.gmail.com with ESMTPSA id a15sm6253847edr.76.2021.11.14.11.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 11:39:55 -0800 (PST)
Date:   Sun, 14 Nov 2021 21:39:54 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: fsl-dspi: use devm_spi_alloc_master()
Message-ID: <20211114193954.suonysr5lpdgpnrj@skbuf>
References: <20211110161754.3312805-1-michael@walle.cc>
 <20211113180642.7doe6dc5iotw5yez@skbuf>
 <cd4b16c6fb46cbb9670b5a9551bc46be@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd4b16c6fb46cbb9670b5a9551bc46be@walle.cc>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, Nov 14, 2021 at 04:44:18PM +0100, Michael Walle wrote:
> Let me know if I should respin the patch or if you like to
> keep the devm_kzalloc() as it is now, because you've mentioned
> you don't like the spi devres mappers. During earlier debugging
> I just noticed the following comment in drivers/spi/spi.c and
> noticed that this driver isn't converted:
> 
> /* Release the last reference on the controller if its driver
>  * has not yet been converted to devm_spi_alloc_master/slave().
>  */

I'm not a huge fan of cargo cult refactoring. I admit I haven't followed
Lukas' work too closely and I don't see why drivers _should_ be
converted to devm_spi_alloc_controller. Traditionally, the devres
helpers were riddled with various gotchas related to deregistration
being performed way too late (leading to peripheral drivers being unable
to access their hardware because the controller's ->remove had already
executed). I said that not making any use of devres would be great
because I sadly don't have enough time to keep up with all the
subtleties of the devm_spi_* helpers, and having everything implemented
in a plain and simple way makes errors more obvious for me to reason
about. So if there isn't any technical reason for this change, I'd
personally pass on it, but it's up to Mark, really.
