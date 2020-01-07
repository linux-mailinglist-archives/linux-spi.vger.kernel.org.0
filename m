Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD7D132171
	for <lists+linux-spi@lfdr.de>; Tue,  7 Jan 2020 09:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgAGIcS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 Jan 2020 03:32:18 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:33017 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgAGIcS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 Jan 2020 03:32:18 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 2AB7622F00;
        Tue,  7 Jan 2020 09:32:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1578385936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xIchMiGIp29bT82F2Y0+NI6NWGwK/LliKCzA+IwwlEk=;
        b=EDBGnW8O7tKNpRfhAz6CsqJoW3j76RnF6Et/sFgmFqKddMO7t8aZledqEEJfDdbERWBZVi
        l8rg0Wr954XX5It7MRUzWoYl1QYk3fA9IScTkJUa2oglQE7AHr/ULcuDiwSojff1q51ymw
        eshPGLElEFNUHzwWhP6t+2ios/z1av0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 07 Jan 2020 09:32:15 +0100
From:   Michael Walle <michael@walle.cc>
To:     Kuldeep Singh <kuldeep.singh@nxp.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [EXT] [PATCH] spi: nxp-fspi: Ensure width is respected in spi-mem
 operations
In-Reply-To: <AM0PR0402MB3556E16D1027FB5D6C3FDC88E03F0@AM0PR0402MB3556.eurprd04.prod.outlook.com>
References: <20191211195730.26794-1-michael@walle.cc>
 <AM0PR0402MB3556E16D1027FB5D6C3FDC88E03F0@AM0PR0402MB3556.eurprd04.prod.outlook.com>
Message-ID: <650f957c95e2ee99db646fe620268ff9@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.8
X-Spamd-Bar: +
X-Spam-Level: *
X-Rspamd-Server: web
X-Spam-Status: No, score=1.40
X-Spam-Score: 1.40
X-Rspamd-Queue-Id: 2AB7622F00
X-Spamd-Result: default: False [1.40 / 15.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         RCPT_COUNT_FIVE(0.00)[6];
         DKIM_SIGNED(0.00)[];
         NEURAL_HAM(-0.00)[-0.218];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,nxp.com,kernel.org];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Am 2020-01-07 06:39, schrieb Kuldeep Singh:
> Hi Michael,
> 
>> -----Original Message-----
>> From: linux-kernel-owner@vger.kernel.org <linux-kernel-
>> owner@vger.kernel.org> On Behalf Of Michael Walle
>> Sent: Thursday, December 12, 2019 1:28 AM
>> To: linux-spi@vger.kernel.org; linux-kernel@vger.kernel.org
>> Cc: Yogesh Gaur <yogeshgaur.83@gmail.com>; Ashish Kumar
>> <ashish.kumar@nxp.com>; Mark Brown <broonie@kernel.org>; Michael
>> Walle <michael@walle.cc>
>> Subject: [EXT] [PATCH] spi: nxp-fspi: Ensure width is respected in 
>> spi-mem
>> operations
>> 
>> Caution: EXT Email
>> 
>> Make use of a core helper to ensure the desired width is respected 
>> when
>> calling spi-mem operators.
>> 
>> Otherwise only the SPI controller will be matched with the flash chip, 
>> which
>> might lead to wrong widths. Also consider the width specified by the 
>> user in
>> the device tree.
> 
> Could you please mention the flash and modes you tested. Does it
> support DUAL/QUAD mode?
> I couldn't test these modes as NXP LS1028ARDB has "mt35xu02g" which
> supports SINGLE and OCTAL modes only.

That commit is already upstream. But FWIW, it was a Winbond W25Q32FW in 
dual i/o mode.

-michael

