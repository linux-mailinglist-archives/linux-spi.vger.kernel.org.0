Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815882F46E0
	for <lists+linux-spi@lfdr.de>; Wed, 13 Jan 2021 09:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbhAMIt5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Jan 2021 03:49:57 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:14097 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726569AbhAMIt5 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 13 Jan 2021 03:49:57 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DG1MZ02Qjz9ty2b;
        Wed, 13 Jan 2021 09:49:14 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id w2qC_Hl_dFfO; Wed, 13 Jan 2021 09:49:13 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DG1MY67tTz9ty2Z;
        Wed, 13 Jan 2021 09:49:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CE5818B7FC;
        Wed, 13 Jan 2021 09:49:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 9x9Yr362zsLB; Wed, 13 Jan 2021 09:49:14 +0100 (CET)
Received: from [172.25.230.103] (po15451.idsi0.si.c-s.fr [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A284A8B7FB;
        Wed, 13 Jan 2021 09:49:14 +0100 (CET)
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: SPI not working on 5.10 and 5.11, bisected to 766c6b63aa04 ("spi: fix
 client driver breakages when using GPIO descriptors")
To:     Sven Van Asbroeck <thesven73@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-spi <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Message-ID: <dc5d8d35-31aa-b36d-72b0-17c8a7c13061@csgroup.eu>
Date:   Wed, 13 Jan 2021 09:49:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello,

My board has powerpc 885 microcontroler. Temperature sensor is an LM74.

Kernel has CONFIG_SPI_FSL_SPI and CONFIG_SPI_FSL_CPM and CONFIG_SENSORS_LM70.

Since kernel 5.10, 'sensors' reports temperature 0°C on my board:

	root@vgoip:~# sensors

	lm74-spi-0-5
	Adapter: SPI adapter
	temp1:         +0.0 C

	lm74-spi-0-1
	Adapter: SPI adapter
	temp1:         +0.0 C

With commit 766c6b63aa04 ("spi: fix client driver breakages when using GPIO descriptors") reverted, 
it is back to work:

	root@vgoip:~# sensors

	lm74-spi-0-5
	Adapter: SPI adapter
	temp1:        +38.9 C

	lm74-spi-0-1
	Adapter: SPI adapter
	temp1:        +37.2 C


What shall I do ?

Thanks
Christophe
