Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27C3C45993
	for <lists+linux-spi@lfdr.de>; Fri, 14 Jun 2019 11:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbfFNJyM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 14 Jun 2019 05:54:12 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:60907 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727370AbfFNJyM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 14 Jun 2019 05:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=DwjFB+oz6/9dGsv4QElwyewJlB8wA+pZrqbOj9RUeCg=;
        b=WUdHT3cyDMmH/DHUZ4nqX3gMnD/79it8cFgTO0W+DRDo2fqdO0wvYdBvYSZhtxsbxl5zSgH9QLMnkAER9zNH40vE+3x9lxM5Toc5XSMVEajubd7XYopk9oDZ2Dnj36VDpLqWcLWi+/FkXkIueIeLIp8lbZ3FchD1LuQcEuAlIqQumzjbYKpmNMBTFN87cv9VfOza/KTnMqCKWbZIa93FosBgUt36hWDrRxYSa8UVRqpy2cL6k/3B2lL9yxCPKxKoKaGSa6icyFvObG2TYXp5Wz3f2FQDmZqLRYG36v/Ok6lICQyXoeyTjQaCkviGpCjPBlq3f/shKZi9wemIVYbY+g==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:57381 helo=[192.168.10.173])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1hbiuP-0005rT-9L; Fri, 14 Jun 2019 11:54:09 +0200
Subject: Re: SPI regression with today's build
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-spi <linux-spi@vger.kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Martin Sperl <kernel@martin.sperl.org>
References: <5be80c08e0873ab200ed472b98ea8772666852ff.camel@suse.de>
 <a2f71bcab3756dc35385288ca3287af6849933a6.camel@suse.de>
 <0f0b3e3c-93c4-b76c-854c-6f498bc017d6@tronnes.org>
 <20190509022701.GS14916@sirena.org.uk>
 <CAHp75VcWB+UyAjXg5rjhw4-g9pJUHLtGwpr1XSSn1rOm+Rm=9g@mail.gmail.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <55f3c32a-ea2d-e2b0-447d-b5d8effbfa36@tronnes.org>
Date:   Fri, 14 Jun 2019 11:54:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VcWB+UyAjXg5rjhw4-g9pJUHLtGwpr1XSSn1rOm+Rm=9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



Den 14.06.2019 10.23, skrev Andy Shevchenko:
> On Thu, May 9, 2019 at 5:27 AM Mark Brown <broonie@kernel.org> wrote:
>>
>> On Wed, May 08, 2019 at 07:33:32PM +0200, Noralf Trønnes wrote:
>>
>>> Unless Martin Sperl, who wrote spi_split_transfers_maxsize(), has other
>>> suggestions, I think we should just revert this patch.
>>
>> I'll just revert for now, we can always re-apply things later but
>> that'll get the problem sorted in Linus' tree quickest.
> 
> I got the same issue on v5.2-rc4. Are you going to submit the fix to v5.2 cycle?
> 

I see the revert in Linus's tree now, so it will be fixed in -rc5.

Noralf.

> P.S. The commit misses Fixes tag AFAICS.
> 
