Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC91951AE0
	for <lists+linux-spi@lfdr.de>; Mon, 24 Jun 2019 20:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbfFXSmx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 Jun 2019 14:42:53 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:42141 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727664AbfFXSmx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 24 Jun 2019 14:42:53 -0400
Received: from [192.168.1.110] ([77.4.138.202]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N2lzA-1iic5w3MB2-0138jG; Mon, 24 Jun 2019 20:42:44 +0200
Subject: Re: [PATCH] spi: spi-gpio: Make probe function __init_or_module
To:     Mark Brown <broonie@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     od@zcrc.me, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190607155631.15072-1-paul@crapouillou.net>
 <20190607155907.GH2456@sirena.org.uk>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <0323abd9-2c68-2d2e-0140-c34edf983f4f@metux.net>
Date:   Mon, 24 Jun 2019 20:42:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190607155907.GH2456@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:B+ndejNADLbmP9NRTeO+zCHd8NO0E21L/8XSu+JU+mD7UOddsph
 U1qSW8obBRMcO4mka1He6D8C+vH8prpf2f+MpWv/FfR2sSDIGyhcw/TsZxFRcvnngqw1kn2
 aWB6yhSbIyei6Kxh0wmIxD4W9ZcGxTPGHnwgo5T7xNrnwUfshZ7jLauXc81VeUpdOOjqdBw
 7MtRnQ7o8j/IJwRVrbX2A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7aKfJg27cUI=:PMcIRU/bPjtyYQ/lc67Q4c
 i+u1enHgsJBu/v9tnbNGZ17JMna8D1SD6pbqIlibzyChudF7uXU+4oN6z43lY/6bib/ERdpU3
 KcCdV6vpYcx0DnPe36iTNr3xFrNRaXx/9sKBkOoG14L8s+EygPyiq/yMzKXKQnBDXvNVFodQL
 IC/zyWDRi/zCMZklIkI7BmOgiN5yBL8NiI0yflMUOO0xny48i3fTwYbOAuoTlKy5WrdSQPj7G
 +bxAlA3As3YMwrqJIJ3pxjKNLkGlFN2V52cMJm3Z48nB3UGEg94FO8L3hG4FESGKCUl2CE/MH
 6msLmhwxMT2/bQvI7du3bB9fmtA8WC6hbzbITt2Hr+UnU3P/PMxLQWrnMYT6oqpZad5qRnHcr
 J+o/j6hubN4Vl2WZEGh5eWtngHh/7gjDfNZy0JhgjKfi6GoUTw336+sHAfE0LDmNphSq3dLNl
 cxnD1/SyLSY0nWp0FkWVW/FXr/O53WkoKnPurzY+a/GaeHSIu8slZKaBRf9QpeB485Gat56AH
 4mIcEIxcZnR+YOpuTM65Og4iBTPJwbMvUObYA6a7MuGpYp/i/j6PDfbJfdiMPPR5FJr13KpSh
 4ardoF3P3Q8NTf8m8kYQZsG1t9ytGxXclAEtSAvzH2/ZOXrtC9roFKoBjfbRE70g6bV7no9OC
 ZsEV1G4gU29v3VfLD6tCrekNckD90lwK4G+K9lomumJqAnp4YgT5o+xVUvr6mlhaEdbvpOpjf
 0Mlmvv+R6WTNvtxqQQi4JekEDyfFYRkDojSRxBxj2h/5NBGzt9BfOmc5SUU=
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 07.06.19 17:59, Mark Brown wrote:
> On Fri, Jun 07, 2019 at 05:56:31PM +0200, Paul Cercueil wrote:
>> This allows the probe function to be dropped after the kernel finished
>> its initialization, in the case where the driver was not compiled as a
>> module.
> 
> Hopefully not since we might probe later on if something registers a new
> device...
> 

Common pitfall. Also fallen into this myself and wondered why
it oops'd :o.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
