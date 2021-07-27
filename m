Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A7A3D7A41
	for <lists+linux-spi@lfdr.de>; Tue, 27 Jul 2021 17:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236974AbhG0Pz2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 27 Jul 2021 11:55:28 -0400
Received: from phobos.denx.de ([85.214.62.61]:39460 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229537AbhG0Pz2 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 27 Jul 2021 11:55:28 -0400
Received: from [IPv6:::1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 02F7D807F3;
        Tue, 27 Jul 2021 17:55:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1627401327;
        bh=P9dIz16NAM3VIDmCTFpDT4X9Gusx49CT4RDrwtvxPy0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FDWYuXTMwxJDQCdCAGdYq4HEt78if51tAZN1kbVvHIRmLfAWZhbn1Kc3OcfBAX8tB
         HER1vj54kdBATiuxYmf9JFsk1TJlm9s0Fdoj67uJjoiL9wNXa7Zlh45CcW8ObqRqLo
         LVrJvNhjZuTVHlZbSm6qmXxh1Ml7FFUQGUA6Zw13pXiH0bAuVAjrw1CTG1CqV3CeB3
         lQqaa8y5V9TrH8OZMH7XXxWWDTH1ZT6uiJm4o48VonqYRJwS+1qlcROgRSJJGxcyP5
         GPx+vgOW0+K7eLUF88Ddent6cnHYMb+UA2vlpjhr7t16rQXOrcB9OrlTs9x2b4Oaxk
         YMldqROovl8rw==
Subject: Re: [PATCH] spi: imx: mx51-ecspi: Fix CONFIGREG delay comment
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
References: <20210726101502.6803-1-marex@denx.de>
 <20210727121554.GA42404@sirena.org.uk>
From:   Marek Vasut <marex@denx.de>
Message-ID: <1bba632f-3558-7ded-393d-a054a26ce7ef@denx.de>
Date:   Tue, 27 Jul 2021 17:55:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210727121554.GA42404@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 7/27/21 2:15 PM, Mark Brown wrote:
> On Mon, Jul 26, 2021 at 12:15:02PM +0200, Marek Vasut wrote:
>> For (2 * 1000000) / min_speed_hz < 10 to be true in naturals with zero,
>> the min_speed_hz must above 222222. Update the comment. No functional
>> change.
> 
> This doesn't apply against current code, please check and resend.

Hm, yes, it conflicts with
[PATCH V2] spi: imx: mx51-ecspi: Fix low-speed CONFIGREG delay calculation

So maybe I'll wait until this one gets applied and picked by stable, and 
then I'll send the comment fix ? That should make things easier.
