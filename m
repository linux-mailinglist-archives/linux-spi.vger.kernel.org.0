Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 102D72F6244
	for <lists+linux-spi@lfdr.de>; Thu, 14 Jan 2021 14:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbhANNnN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 14 Jan 2021 08:43:13 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:23382 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbhANNnM (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 14 Jan 2021 08:43:12 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DGlqM5wN3z9v19N;
        Thu, 14 Jan 2021 14:42:23 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id u1zD7buZkaAG; Thu, 14 Jan 2021 14:42:23 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DGlqM4cB3z9v19G;
        Thu, 14 Jan 2021 14:42:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 27DBD8B802;
        Thu, 14 Jan 2021 14:42:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 5HIyx97OUY-n; Thu, 14 Jan 2021 14:42:25 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B45028B800;
        Thu, 14 Jan 2021 14:42:24 +0100 (CET)
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
 <9400d900-f315-815f-a358-16ed4963da6c@csgroup.eu>
 <20210114115958.GB4854@sirena.org.uk>
 <006d1594-8eec-3aad-1651-919071e89f3b@csgroup.eu>
 <20210114132258.GD4854@sirena.org.uk>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <adbf508d-ed5a-e06a-4a59-98df0229d7b4@csgroup.eu>
Date:   Thu, 14 Jan 2021 14:42:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210114132258.GD4854@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



Le 14/01/2021 à 14:22, Mark Brown a écrit :
> 
> For GPIO chipselects you should really fix the driver to just hand the
> GPIO off to the core rather than trying to implement this itself, that
> will avoid driver specific differences like this.
> 

IIUC, it is not trivial as it requires implementing transfer_one() instead of the existing 
transfer_one_message() in the driver. Am I right ?

What's the difference/benefit of transfer_one() compared to the existing transfer_one_message() ?
