Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90F7044C505
	for <lists+linux-spi@lfdr.de>; Wed, 10 Nov 2021 17:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbhKJQdi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 10 Nov 2021 11:33:38 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:51883 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhKJQdh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 10 Nov 2021 11:33:37 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id B86192223B;
        Wed, 10 Nov 2021 17:30:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1636561848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s8XdE4Cnh8oZw1I1NMg2uVodPcRrJMrWzEcOayqrrh8=;
        b=OQ+Y9VFhFIw8dA3f94aY3dTsNtSzD3AffGE4aFEyUkxJ37POV+vLh17nvStQHOlaa5AGDA
        W9OPTGXS9O1Wc02WKgHTvBv0C5qkT3Uearbhm8tu1OZeGe18kQkWJdBvmT+WQoMJIY4+F8
        1xeyQ7+Mzi9tZlySiDVUGaPwudO3tho=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 10 Nov 2021 17:30:48 +0100
From:   Michael Walle <michael@walle.cc>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Uw?= =?UTF-8?Q?e_Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [RFC PATCH] spi: fix use-after-free of the add_lock mutex
In-Reply-To: <YYvy79HfTvy8hC5/@sirena.org.uk>
References: <20211110160836.3304104-1-michael@walle.cc>
 <YYvy79HfTvy8hC5/@sirena.org.uk>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <116159a7cf1e7cb3817aa31931b81d91@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Am 2021-11-10 17:27, schrieb Mark Brown:
>> For reference, the kernel oops is:
>> [   20.242505] Unable to handle kernel paging request at virtual 
>> address 0042a2203dc65260
>> [   20.250468] Mem abort info:
>> [   20.253270]   ESR = 0x96000044
> 
> Please think hard before including complete backtraces in upstream
> reports, they are very large and contain almost no useful information
> relative to their size so often obscure the relevant content in your
> message. If part of the backtrace is usefully illustrative (it often is
> for search engines if nothing else) then it's usually better to pull 
> out
> the relevant sections.

It was in the comments section of the patch, for exactly this purpose.
That's how you're doing it, no?

-michael
