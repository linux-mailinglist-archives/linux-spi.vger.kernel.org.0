Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C689B22822C
	for <lists+linux-spi@lfdr.de>; Tue, 21 Jul 2020 16:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbgGUO3x (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Jul 2020 10:29:53 -0400
Received: from office2.cesnet.cz ([195.113.144.244]:49232 "EHLO
        office2.cesnet.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728600AbgGUO3w (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Jul 2020 10:29:52 -0400
X-Greylist: delayed 588 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Jul 2020 10:29:51 EDT
Received: from localhost (ip-62-245-120-230.net.upcbroadband.cz [62.245.120.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by office2.cesnet.cz (Postfix) with ESMTPSA id 8B954400068;
        Tue, 21 Jul 2020 16:20:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
        s=office2-2020; t=1595341202;
        bh=ygojBjo8uRtPyh1pazNEnNB95MLKWaJxooH5K37/hdE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=DX5bzQP9eqMDV4W2/mxRHKQQiEWWfH+hJSr/R7LXpAWvwz5x6ryPkpbphqw6qlCDn
         oPGzB1jDMAuKg5wpQMDyrdMCFpo1SOGlzWt02wsBYw/Q7bf0MtCcOMkK2yQ4qhvDiS
         30yt5eW3v09z1GgEaMqVZVyJU7cSQ4ab6Vqq8sdrL677psA8A/BYG1UZgPA/HcJo3d
         JJEWSe/9GWwwYcdc903f7TB6gPuwGRlIH4YPB4GWNOjWElgrUjbQcwtqfRNZk1XIha
         vjFjpcHorNivi8PPYXjOYcrssqU+QiQGU4t8A9pw2IA4r3ydlAYpgLbOaKhyWL9MWM
         srXEa4ORTGb9w==
From:   =?iso-8859-1?Q?Jan_Kundr=E1t?= <jan.kundrat@cesnet.cz>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     <linux-spi@vger.kernel.org>, Mark Brown <broonie@kernel.org>
Subject: Re: High CPU load when using MAX14830 SPI UART controller
Date:   Tue, 21 Jul 2020 16:20:02 +0200
MIME-Version: 1.0
Message-ID: <070e2fa9-bacf-4d6e-a62a-63b3db55c25e@cesnet.cz>
In-Reply-To: <20200721155139.40fdb835@windsurf.home>
References: <20200519163353.20c03286@windsurf.home>
 <4c5c972b-c8b8-4326-a1f9-438d88217a4a@cesnet.cz>
 <20200721155139.40fdb835@windsurf.home>
Organization: CESNET
User-Agent: Trojita/v0.7-433-gac16951c6-dirty; Qt/5.13.0; xcb; Linux; Gentoo Base System release 2.4.1
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

>> The MAX14830 supports also another mode of operation where the interrupt=20=

>> fires only when the RX buffer gets filled over a configurable minimal=20
>> threshold. This can be combined with yet another interrupt which fires=20
>> whenever there's some data in the RX FIFO for "too long". Unfortunately,=20=

>> this timer starts over again upon reception of any additional=20
>> data, so it's=20
>> the *youngest* byte in the RX FIFO that controls triggering of=20
>> this delayed=20
>> interrupt.
>
> Do you have some more details about this mode of operation? I looked a
> bit at the MAX14830 datasheet and code, but couldn't spot what allows
> an interrupt to be triggered after X bytes have been received *OR* if
> data has been sitting in the FIFO for too long.

I have no code, but according to the datasheet, it's the "RTimeout" bit=20
(Line Status Register, bit 0). If properly configured (RxTimeOut set and=20
the interrupt routing enabled via LSRIntEn[0], the "RTimeoutIEn" bit),=20
we're supposed to get ISR[0] set upon this timeout.

I have not tried it, I just read the datasheet a few years ago. When you=20
have patches, I'll be happy to test them (likely only in September, though,=20=

because of vacations).

With kind regards,
Jan
