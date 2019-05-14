Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED0611C617
	for <lists+linux-spi@lfdr.de>; Tue, 14 May 2019 11:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfENJdp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 May 2019 05:33:45 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:18670 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfENJdp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 May 2019 05:33:45 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cda8b740001>; Tue, 14 May 2019 02:33:40 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 14 May 2019 02:33:44 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 14 May 2019 02:33:44 -0700
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 14 May
 2019 09:33:42 +0000
Subject: Re: [PATCH V5 1/4] spi: tegra114: add support for gpio based CS
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        <thierry.reding@gmail.com>, <ldewangan@nvidia.com>,
        <broonie@kernel.org>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
References: <1557810235-16401-1-git-send-email-skomatineni@nvidia.com>
 <1557810235-16401-2-git-send-email-skomatineni@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <cf4bd167-49b8-5649-a2e2-7bf5ddcc6e2d@nvidia.com>
Date:   Tue, 14 May 2019 10:33:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1557810235-16401-2-git-send-email-skomatineni@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557826420; bh=SppUGGkQiIfOreEGJ0gp41fqANbwlVGWqwB/RkgMYEs=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=crHKh9AoTrRZR2t1DyQhwrbWeZ4lfkpx15upl8kl/cm/hIwXkVJXG9BeBeEMgYczS
         g3ObQFGnRU9MKkFIVbF43wRJYMUEmd1AvWSmHTDtiHnHLAzUJrDHV1iWA91nFSldjR
         7uLJV5EgPSWoUB74FTIHFE6MTqXW4hm0+bnxOAKujElHJuwtXdrxsKQ5rm1Le1dhUH
         qIjva0zeXJ6FAzE0rt8/G5hve+KA3uwe3CgIADJDn2ibk9mAdAsMPW+2ZhgWfqWQ9k
         Ftg3eZIjzV70+0+1FID2PAoudpAEAyyqTZHmY9RUnZOskfco6yxDsoIo2vYEOLyNLR
         wLIm4CTzkQYSA==
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 14/05/2019 06:03, Sowjanya Komatineni wrote:
> This patch adds support for GPIO based CS control through SPI core
> function spi_set_cs.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Can you elaborate on the use-case where this is needed? I am curious
what platforms are using this and why they would not use the dedicated
CS signals.

Cheers
Jon

-- 
nvpublic
