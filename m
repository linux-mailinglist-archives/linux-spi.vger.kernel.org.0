Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD32927400
	for <lists+linux-spi@lfdr.de>; Thu, 23 May 2019 03:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbfEWB3t (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 May 2019 21:29:49 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:19556 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbfEWB3t (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 22 May 2019 21:29:49 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ce5f7880000>; Wed, 22 May 2019 18:29:44 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 22 May 2019 18:29:48 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 22 May 2019 18:29:48 -0700
Received: from [10.2.170.210] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 23 May
 2019 01:29:46 +0000
Subject: Re: [PATCH V1 00/12] LP0 entry and exit support for Tegra210
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <ldewangan@nvidia.com>, <broonie@kernel.org>,
        <natechancellor@gmail.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
References: <1558574922-16531-1-git-send-email-skomatineni@nvidia.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <0418cbdb-1bb6-23c3-f13d-e0a70f899f3c@nvidia.com>
Date:   Wed, 22 May 2019 18:29:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1558574922-16531-1-git-send-email-skomatineni@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558574984; bh=iArqTE+js56+O2/nbQ1GpZLkqXxaKFPuqNJHbGlsARI=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=TtjipGVK4xhFgrbYoPGkmerDXLj/Z0o/+ZCFd4wanpqk7LDH0IjcmKW4sXmZOhFEN
         uwQhbKJ2jWAORYYHmQtgrKmdhuu64c/JB0xM3CxYBVhvUQHY+wZmMnJ8Kr5dle7cA4
         97Ql74z9gS3hFpEBxsX8QsLFTz+OAknpuWd1umMZTDbCPGLXhzI6fAX/KI2hKIVAGv
         MpKX0BrI9j/4nfXRDPT0uDJFkLK3NJ2vJdFt5YNhOVKAUn2jQCqNaANj03uoQWVRA2
         H+k8Jrszl9zpdRaJ83a65JHX9Mh1B57nBbpb+RM2rDPJIeiCZdObi1SapoLgdh1nAm
         FDuTTJeQ81KJw==
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

HI All

Sorry. Please ignore this as it was sent out accidentally

thanks

sowjanya

On 5/22/19 6:28 PM, Sowjanya Komatineni wrote:
> This patch series includes Tegra210 deepsleep or LP0 support with
> deep sleep exit through RTC alarm wake and power button wake events.
>
> This series also includes save and restore of PLLs, clocks, OSC contexts
> for basic LP0 exit.
>
> This patch series is doesn't support for 100% suspend/resume to fully
> functional state and we are working on some more drivers suspend and
> resume implementations.
>
> Sowjanya Komatineni (12):
>    irqchip: tegra: do not disable COP IRQ during suspend
>    pinctrl: tegra: add suspend and resume support
>    clk: tegra: save and restore PLLs state for system
>    clk: tegra: add support for peripheral clock suspend and resume
>    clk: tegra: add support for OSC clock resume
>    clk: tegra: add suspend resume support for DFLL clock
>    clk: tegra: support for Tegra210 clocks suspend-resume
>    soc/tegra: pmc: allow support for more tegra wake models
>    soc/tegra: pmc: add pmc wake support for tegra210
>    gpio: tegra: implement wake event support for Tegra210 and prior GPIO
>    soc/tegra: pmc: configure tegra deep sleep control settings
>    arm64: tegra: enable wake from deep sleep on RTC alarm.
>
>   arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi |   7 +
>   arch/arm64/boot/dts/nvidia/tegra210.dtsi       |   5 +-
>   drivers/clk/tegra/clk-dfll.c                   |  82 ++++++
>   drivers/clk/tegra/clk-dfll.h                   |   2 +
>   drivers/clk/tegra/clk-divider.c                |  19 ++
>   drivers/clk/tegra/clk-pll-out.c                |  25 ++
>   drivers/clk/tegra/clk-pll.c                    | 220 ++++++++++++--
>   drivers/clk/tegra/clk-tegra-fixed.c            |  15 +
>   drivers/clk/tegra/clk-tegra210.c               | 382 +++++++++++++++++++++++++
>   drivers/clk/tegra/clk.c                        |  74 ++++-
>   drivers/clk/tegra/clk.h                        |  18 ++
>   drivers/gpio/gpio-tegra.c                      | 109 ++++++-
>   drivers/irqchip/irq-tegra.c                    |  10 +-
>   drivers/pinctrl/tegra/pinctrl-tegra.c          |  68 ++++-
>   drivers/pinctrl/tegra/pinctrl-tegra.h          |   3 +
>   drivers/pinctrl/tegra/pinctrl-tegra114.c       |   1 +
>   drivers/pinctrl/tegra/pinctrl-tegra124.c       |   1 +
>   drivers/pinctrl/tegra/pinctrl-tegra20.c        |   1 +
>   drivers/pinctrl/tegra/pinctrl-tegra210.c       |   1 +
>   drivers/pinctrl/tegra/pinctrl-tegra30.c        |   1 +
>   drivers/soc/tegra/pmc.c                        | 159 +++++++++-
>   21 files changed, 1167 insertions(+), 36 deletions(-)
>
