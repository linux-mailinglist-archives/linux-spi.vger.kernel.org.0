Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4372F5FEC
	for <lists+linux-spi@lfdr.de>; Thu, 14 Jan 2021 12:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbhANL2f (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 14 Jan 2021 06:28:35 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:19469 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbhANL2f (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 14 Jan 2021 06:28:35 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DGhr15N7dz9v19B;
        Thu, 14 Jan 2021 12:27:45 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id I8b1oyYPNNXT; Thu, 14 Jan 2021 12:27:45 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DGhr142PFz9v18k;
        Thu, 14 Jan 2021 12:27:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DE07F8B801;
        Thu, 14 Jan 2021 12:27:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id eJEDNHFrKG5m; Thu, 14 Jan 2021 12:27:46 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7C4D68B800;
        Thu, 14 Jan 2021 12:27:46 +0100 (CET)
Subject: Re: SPI not working on 5.10 and 5.11, bisected to 766c6b63aa04 ("spi:
 fix client driver breakages when using GPIO descriptors")
To:     Mark Brown <broonie@kernel.org>
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
References: <dc5d8d35-31aa-b36d-72b0-17c8a7c13061@csgroup.eu>
 <20210113123345.GD4641@sirena.org.uk>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <9400d900-f315-815f-a358-16ed4963da6c@csgroup.eu>
Date:   Thu, 14 Jan 2021 12:27:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210113123345.GD4641@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



Le 13/01/2021 à 13:33, Mark Brown a écrit :
> On Wed, Jan 13, 2021 at 09:49:12AM +0100, Christophe Leroy wrote:
> 
>> With commit 766c6b63aa04 ("spi: fix client driver breakages when using GPIO
>> descriptors") reverted, it is back to work:
> 
> ...
> 
>> What shall I do ?
> 
> I would guess that there's an error with the chip select polarity
> configuration on your system that just happened to work previously, I'd
> suggest fixing this in the board configuration to bring it in line with
> everything else.
> 

Not that easy.

Today I have in the DTS the CS GPIOs declared as ACTIVE_LOW.

If I declare them as ACTIVE_HIGH instead, then I also have to set spi-cs-high property, otherwise 
of_gpio_flags_quirks() is not happy and forces the GPIO ACTIVE LOW.

When I set spi-cs-high property, it sets the SPI_CS_HIGH bit in spi->mode.

In fsl_spi_chipselect(), we have

	bool pol = spi->mode & SPI_CS_HIGH

Then
	pdata->cs_control(spi, pol);

So changing the board config is compensated by the above, and at the end it still doesn't work.


Whereas reverting the above mentionned commit sets back SPI_CS_HIGH into spi->mode without changing 
the ACTIVE level of the GPIO, resulting in the correct polarity.


So, I'm a bit lost, where is the problem exactly ?

Thanks
Christophe
