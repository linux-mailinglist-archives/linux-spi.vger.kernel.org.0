Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E14B1366F09
	for <lists+linux-spi@lfdr.de>; Wed, 21 Apr 2021 17:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243954AbhDUPXD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 21 Apr 2021 11:23:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:52220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243948AbhDUPXB (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 21 Apr 2021 11:23:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8642C61449;
        Wed, 21 Apr 2021 15:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619018548;
        bh=pvwwIu6oOHIsP+uwY3IwgDLl3PrH3VYKaxq41zQERIk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mxrkJDWFajcdJkMkO/LHztz8ks3AjaLyO+kErwkzxuJe9/rvdT/arWXfl2ZM3628U
         HybiEqTzByh0teBcXDYccsY3Y1h7jbSKOrEjjBc9zzI+/3/ELHJIDqsXfqNPnLobK5
         oIlV2GjV5Jjwr73W2G2rqLLh0MlrpIUzf6k/N6SFQXO+FwNbYEcUXlBZE9cyho4iTY
         88CVE7gATKBwQNYeF59ankLolFwhgqiprQolhRNG5Wql6xPJhugizyRnKGqZ3lXtT8
         EQey4lhsEDkUW/YkbxG+s/vxaz34nkl4ibRVzA/r24v401kX4cJnU+jkw2kJ6KNthq
         JSkk+8bIO5M2w==
Received: by mail-wr1-f47.google.com with SMTP id x7so41748159wrw.10;
        Wed, 21 Apr 2021 08:22:28 -0700 (PDT)
X-Gm-Message-State: AOAM530Qk9kKjoTRVJq0Xiy+vwU4x9Qoj0rDgwv1W+ya7ffkOg4ZndSZ
        brzs8w2R7iMjqtr2HcgIVm0kVV3L/O5puvrtP2U=
X-Google-Smtp-Source: ABdhPJzPbFIC/rM6E4UNiWQK3iEIDF5w3ubpT3CeNfAbpx0+eskNOiNKpuxyllSes8uq+p5xavAE44qb+Jqma+R21QY=
X-Received: by 2002:adf:c70b:: with SMTP id k11mr28310682wrg.165.1619018547041;
 Wed, 21 Apr 2021 08:22:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210421140653.3964725-1-arnd@kernel.org> <20210421150510.GA36785@sirena.org.uk>
In-Reply-To: <20210421150510.GA36785@sirena.org.uk>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 21 Apr 2021 17:22:08 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0CWp_H-tm2QcZyH1FDXwzMgxY_9dc1Y8pA28MQKT-q=A@mail.gmail.com>
Message-ID: <CAK8P3a0CWp_H-tm2QcZyH1FDXwzMgxY_9dc1Y8pA28MQKT-q=A@mail.gmail.com>
Subject: Re: [PATCH] spi: stm32-qspi: fix debug format string
To:     Mark Brown <broonie@kernel.org>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Zhang Qilong <zhangqilong3@huawei.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Apr 21, 2021 at 5:05 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Apr 21, 2021 at 04:06:48PM +0200, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > Printing size_t needs a special %zd format modifier to avoid a
> > warning like:
>
> This doesn't apply against current code, please check and resend.

It appears that you just applied 1b8a7d4282c0 ("spi: stm32-qspi:
Fix compilation warning in ARM64") after today's linux-next was
cut.

I suspect Patrice's patch now causes a warning on all architectures
on which size_t is defined as 'unsigned int'.

       Arnd
