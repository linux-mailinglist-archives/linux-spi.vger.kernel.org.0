Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E0A3EF975
	for <lists+linux-spi@lfdr.de>; Wed, 18 Aug 2021 06:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237394AbhHREe6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 18 Aug 2021 00:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhHREe5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 18 Aug 2021 00:34:57 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A82C0613C1
        for <linux-spi@vger.kernel.org>; Tue, 17 Aug 2021 21:34:23 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id f3so1040935plg.3
        for <linux-spi@vger.kernel.org>; Tue, 17 Aug 2021 21:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=eqqpYWePv3bA2FFLn8JZZpHhH3Zi1uHmK7sHrQbWFRw=;
        b=HTtKdG+zPt9q7oo6G+tDPFjywlUf2fIlTsljJrBXemAFCqVrXkLJH2J4prixqFwlWE
         J0unc6IdtxCIWudbX02SO4ATFxlaCA1/SoUQMq5P6D3Yk+OduOvpAgff7we5YXfkgCXL
         xlXEBHCz776bTxOcJUNBOjuFaUsXP9ZzpIxEjcZgNlKhHXQmSXT4WG5V74nVrjqmloLj
         jHkkS9fxFa3uYd/EQoKSWBdLGmIyIORJT1upv4QdPBmxwIAVox5/qef1kPsgzwvpXT4k
         bTjafbU59iMyj4iWu6735iceyC6eQ4HGcIB0qT1Sv4H6XxtMpHDdFpm5Po4IlPj8a0jc
         JKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=eqqpYWePv3bA2FFLn8JZZpHhH3Zi1uHmK7sHrQbWFRw=;
        b=OI8kPtDRLu2Va8YIhO5cDlgkkGTZqkRXOoAn9MThKk4lsEXt4MUWehrtfyl45/6JUj
         Fxc/7jwL/QPm+5cGy+Q0Qb4PUsvCAYY6Aj5+P1Kz4n5ST2aPWZdEH6eH1NBg+xjcVZsb
         ASakKPAiVr3CvWM95WBVta7CpqMMQU3Hmy5Ymxf93pqUYTHk4XmaGCtxy7V/cayl7iN/
         M/aJckN6XGyfFI02GYqEGl/O059t1QBazVCwvTZ6xvW6Mn6msOVB06QJa0lc79/QEruM
         cx7kocdeuB7lA7LNn/tRjU5fejVuy8v4Yo96IyXJVOwcIZhU84TIMqjzSW0WIRglrelQ
         VDqg==
X-Gm-Message-State: AOAM5329Aa4mh8UY9vRom0w8S1mnvzMzkMV66wm9W/PhEtOHkmjafeZH
        r6PKINjGXlnEQycW58TA8vFJew==
X-Google-Smtp-Source: ABdhPJyyJyLRvTMcV2VMadnYuEIWvMA5nKw+OEK9l2guzi40QLIRwlX68yRwxZh/lfXmuYEMO47Zng==
X-Received: by 2002:a17:90b:1983:: with SMTP id mv3mr940040pjb.185.1629261263184;
        Tue, 17 Aug 2021 21:34:23 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id f5sm4152122pfn.134.2021.08.17.21.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 21:34:22 -0700 (PDT)
Date:   Wed, 18 Aug 2021 10:04:21 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Peter Chen <peter.chen@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Lucas Stach <dev@lynxeye.de>, Stefan Agner <stefan@agner.ch>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-spi@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v8 01/34] opp: Add dev_pm_opp_sync() helper
Message-ID: <20210818043421.cxa4gjrzerakmxxm@vireshk-i7>
References: <20210817012754.8710-1-digetx@gmail.com>
 <20210817012754.8710-2-digetx@gmail.com>
 <20210817075515.vyyv7z37e6jcrhsl@vireshk-i7>
 <710261d9-7ae3-5155-c0a2-f8aed2408d0b@gmail.com>
 <20210818035533.ieqkexltfvvf2p4n@vireshk-i7>
 <5b2a80c1-9743-e633-6257-ede94c8a274c@gmail.com>
 <6df0ed60-e497-0af2-09b6-a9d82f502f17@gmail.com>
 <6438bdfb-3e9e-40dd-fa7c-c79f0892e12a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6438bdfb-3e9e-40dd-fa7c-c79f0892e12a@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 18-08-21, 07:30, Dmitry Osipenko wrote:
> 18.08.2021 07:29, Dmitry Osipenko пишет:
> >> The first resume initializes the OPP state on sync, all further syncs on
> >> resume are no-ops.
> >>
> > 
> > Notice that we use GENPD here. GENPD core takes care of storing PD's
> > performance state (voltage in case of Tegra) and dropping it to 0 after
> > rpm-suspend, GENPD core also restores the state before rpm-resume.
> 
> By 'here' I mean in this series.

It is still not clear to me why you need to this on resume, and not
probe.

-- 
viresh
