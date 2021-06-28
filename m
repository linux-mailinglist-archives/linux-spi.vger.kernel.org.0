Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEEA23B6721
	for <lists+linux-spi@lfdr.de>; Mon, 28 Jun 2021 18:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbhF1Q7Z (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 28 Jun 2021 12:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbhF1Q7Y (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 28 Jun 2021 12:59:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD344C061760;
        Mon, 28 Jun 2021 09:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=woA5VoqAy7gFfT8dSEPQ9NehE3AhROEzmAkvRXaF6uM=; b=fq+lsGBs1466CQSA8ieXMG67tE
        1dbuPBb6McuRA80xgoq1KSrP6hlVQoLEFvVJ6htxEISr/yqP2VZG6bxXLsBWGJ/yirVQcocFXkUwb
        8jPb32aclLvc0vuCLojNqdRsHGqlEVWkLUdTbhRolwjO/iqo1qeJwTnFAQl3GNhEkwVnFRi34sVQS
        yHA+R+j7x9z8ZOeN/42v/Y13tqKWupg10jDRQgCgVIXt7/EaYDGKg75euQxy7XyewIo3kXrqNOjwb
        gWmcyHIS2trYvAlKph2wOQqO8NPH9SlNDKHXD7Xi7hZobzXA+qn2OaHP3JhaK1MkBLGtQX0aN8iI4
        K0jha29Q==;
Received: from [2601:1c0:6280:3f0::aefb]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxuZ6-008k66-Nd; Mon, 28 Jun 2021 16:56:56 +0000
Subject: Re: [PATCH] spi: <linux/spi/spi.h>: add missing struct kernel-doc
 entry
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-kernel@vger.kernel.org,
        "William A . Kennington III" <wak@google.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
References: <20210628004023.7371-1-rdunlap@infradead.org>
 <20210628070542.GA5771@wunner.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <32f6bf08-a80f-7d47-18b2-42f6516c2772@infradead.org>
Date:   Mon, 28 Jun 2021 09:56:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210628070542.GA5771@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 6/28/21 12:05 AM, Lukas Wunner wrote:
> On Sun, Jun 27, 2021 at 05:40:23PM -0700, Randy Dunlap wrote:
>> --- linux-next-20210625.orig/include/linux/spi/spi.h
>> +++ linux-next-20210625/include/linux/spi/spi.h
>> @@ -339,6 +339,7 @@ extern struct spi_device *spi_new_ancill
>>   * @max_speed_hz: Highest supported transfer speed
>>   * @flags: other constraints relevant to this driver
>>   * @slave: indicates that this is an SPI slave controller
>> + * @devm_allocated: flag indicating this is a non-devres managed controller
> 
> Actually the flag indicates that the *allocation* of the controller *is*
> devres-managed, so instead of the above I'd suggest something along the
> lines of:
> 
>  * @devm_allocated: whether allocation of this struct is devres-managed
> 
> Thanks,

Hi Lukas,

OK, I'll change it like that.
I had just copied a comment from below in that same file.
I think that I should fix that comment as well.

Thanks.
