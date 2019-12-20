Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D71B127ED7
	for <lists+linux-spi@lfdr.de>; Fri, 20 Dec 2019 15:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfLTO5l (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 20 Dec 2019 09:57:41 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40792 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbfLTO5l (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 20 Dec 2019 09:57:41 -0500
Received: by mail-lf1-f65.google.com with SMTP id i23so7254552lfo.7
        for <linux-spi@vger.kernel.org>; Fri, 20 Dec 2019 06:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=newoldbits-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TTffZ6t0AN2kjikt4FjnFdPlMcK/C5K5XKPExKg2y5Y=;
        b=O3AwR2dadza+UZNx1UnRWImTO5nEZmvpBrWacqtziBEZGTWfEMWbX5YgXbe0PhTTrd
         eajiSsCMWCrcsh2JfMSy4qlUhEGwG9Su2ka53C5VhXrFsfBLOJqkQ/Lc5bjhZi8HfKzV
         4MZcd8nRTinKy9GD6/yeGDGchMCfjYE2x1QOAcGOvdtVwUPrlSuqZp6+V5ZRnvpgNFqz
         a5C5zH0ImSkFX7iC385sq044h6TMbIg89Gfc6l069PRyCqf6ypcCMwyKqHQQepgOhmdP
         9HELRF7lXot6Svo/iMr6x3izl1SgPcXj+WN26ioJ9mIZ1S6AE0DAUDn4J4pvDp9lAis+
         0uvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TTffZ6t0AN2kjikt4FjnFdPlMcK/C5K5XKPExKg2y5Y=;
        b=WmFuZj3fb5CUEkzf65syuV6Z3171UKmt85Dqza4kBT8M/s9aeLVBL3GHt/E2S83PUx
         ENQXmCUuWAmRsymAn3bpFmeLsCPl9TpGSNuF83cH02MXtP4uiztmENIMDl1CXwdHSqvZ
         Amy8o8eK3Puxp4EQQt8fc2NVGjFsGu+mDrlQnQOGkY2b3nO7cqn+7qojOS0yVfcpiOZ/
         NNqlijt3+iq9qY90QGmi9wLQk/ldAVsd8fyMzeffsAS9aoQAq/XLwysQYEUxPuH2jYL1
         rOQva9ZkvvJvwVRZmo+8ZUlxidUr9GfMiNPS5VI8MOTYypcj/VwEovP4+B9gS4ND2RuH
         e+8w==
X-Gm-Message-State: APjAAAUAv65M2tOSs5qikRUL9+FJuE4Ka9B1yzgB6uZ4GAb+mXmzfR4O
        tqol+bBKleenM1qVn5lXZsu2jxqFHXwK6aBwHHBcyg==
X-Google-Smtp-Source: APXvYqwZuqbR3nPFr6sgZtKzarS6QcMky53rzR6rCkam3agEaKi4WRVx2z06MiF66k5uKfNCvQ1sXVOjGlojhlXgwro=
X-Received: by 2002:ac2:4d04:: with SMTP id r4mr9151809lfi.77.1576853859832;
 Fri, 20 Dec 2019 06:57:39 -0800 (PST)
MIME-Version: 1.0
References: <20191211193954.747745-1-jean.pihet@newoldbits.com>
 <CAORVsuUA3KTMFMiLJbFfSMMB3LupCZWm-2BBs46z6scGH45Vdw@mail.gmail.com> <20191220115928.GA4790@sirena.org.uk>
In-Reply-To: <20191220115928.GA4790@sirena.org.uk>
From:   Jean Pihet <jean.pihet@newoldbits.com>
Date:   Fri, 20 Dec 2019 15:57:28 +0100
Message-ID: <CAORVsuXT14a0O+weZ6P=8QwE-dYOAzRbxADZicHG6Kuf_EqhzQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] spi: spi-ti-qspi: Support large NOR SPI flash
To:     Mark Brown <broonie@kernel.org>
Cc:     Tony Lindgren <tony@atomide.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-spi@vger.kernel.org,
        Ryan Barnett <ryan.barnett@rockwellcollins.com>,
        Conrad Ratschan <conrad.ratschan@rockwellcollins.com>,
        Arnout Vandecappelle <arnout.vandecappelle@essensium.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Dec 20, 2019 at 12:59 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Dec 17, 2019 at 01:24:15PM +0100, Jean Pihet wrote:
> > Hi Mark, Tony, Vignesh,
> >
> > Ping on this series V2. Can you please check the reworked patches?
>
> Please don't send content free pings and please allow a reasonable time
> for review.  People get busy, go on holiday, attend conferences and so
> on so unless there is some reason for urgency (like critical bug fixes)
> please allow at least a couple of weeks for review.  If there have been
> review comments then people may be waiting for those to be addressed.

Sorry about that, I did not know if sending again was better than a
(gentle) ping.

Thanks for reviewing!

Regards,
Jean

>
> Sending content free pings adds to the mail volume (if they are seen at
> all) which is often the problem and since they can't be reviewed
> directly if something has gone wrong you'll have to resend the patches
> anyway, so sending again is generally a better approach though there are
> some other maintainers who like them - if in doubt look at how patches
> for the subsystem are normally handled.
