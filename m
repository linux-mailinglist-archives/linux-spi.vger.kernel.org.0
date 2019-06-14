Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9755459AF
	for <lists+linux-spi@lfdr.de>; Fri, 14 Jun 2019 11:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfFNJ4i (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 14 Jun 2019 05:56:38 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:39163 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfFNJ4i (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 14 Jun 2019 05:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=z+WAsQwaZrobkD5hl+mQaoeKvdgKDOpDN5ZqXwuqnE4=;
        b=h5ecO3w6hvq4gJrZqwk44Bww69lMINGLsDy57F9elFTbfeb0lehd434I/FfN3H+nnlPOb6ulkbXvSPp9mm2v6Q2y8H9Kwp/ycARqBywBPfV/AKU6AuN1+BB2qK+4mbYjozFyM/0Z2N/OyTpR+vdIE3tXQ3BfrFQ9UeuF8GbXJcUeCuf/rpXB1nEj7VuqGfOuonfLGZpNGMPnHMKx8UjGHgBQDwD3eAI7i70WM9XpTU0LNgoh+TIxetgNGPwn1UTO43buuf8zRMf6+fwOQf39U3iQfKNQXIP9ExRML92f8qeupfDwT3pvk4aXJt3b9H6HePXDP2C+fPBRSzsG7LQbnQ==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:57384 helo=[192.168.10.173])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1hbiwl-0006nw-QD; Fri, 14 Jun 2019 11:56:35 +0200
Subject: Re: SPI regression with today's build
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Martin Sperl <kernel@martin.sperl.org>
References: <5be80c08e0873ab200ed472b98ea8772666852ff.camel@suse.de>
 <a2f71bcab3756dc35385288ca3287af6849933a6.camel@suse.de>
 <0f0b3e3c-93c4-b76c-854c-6f498bc017d6@tronnes.org>
 <CAHp75VdhfYXa_6wkYD+_DYQh1k5Mc43e6yF4uj00e6EvgGuOHg@mail.gmail.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <d9be77a9-5198-fc80-636b-41865f3eec85@tronnes.org>
Date:   Fri, 14 Jun 2019 11:56:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdhfYXa_6wkYD+_DYQh1k5Mc43e6yF4uj00e6EvgGuOHg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



Den 14.06.2019 10.28, skrev Andy Shevchenko:
> On Wed, May 8, 2019 at 9:27 PM Noralf Trønnes <noralf@tronnes.org> wrote:
>> [cc:Martin]
>> Den 08.05.2019 19.07, skrev Nicolas Saenz Julienne:
> 
>> Unless Martin Sperl, who wrote spi_split_transfers_maxsize(), has other
>> suggestions, I think we should just revert this patch.
> 
> I gave a suggestion during LPC 2016 about this all stuff. We have to
> provide a DMA channel capability to tell user what is the maximum
> length is supported by the DMA engine. In such case the user may
> prepare the transfers which are satisfying limitations and no
> recreation is necessary, moreover, it will be performance wise to do
> so.
> 

In this case the problem isn't the DMA engine, but the SPI controller
DLEN register which limits the overall transfer to ~64kB.

Noralf.

