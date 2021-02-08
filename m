Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72046313CEF
	for <lists+linux-spi@lfdr.de>; Mon,  8 Feb 2021 19:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbhBHSN6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 8 Feb 2021 13:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235552AbhBHSNL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 8 Feb 2021 13:13:11 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E93C06178A;
        Mon,  8 Feb 2021 10:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=M/evnVn9TCTrgOS7lMU8kDG+WlcHOHkMBOuqA/rlMNU=; b=DJioOhO3ay/e6VYsVYnspxfYu4
        5hVJe9q3VHYjm9x8c9FP24XshRpJhNmP1RMUo0B6QDQYqjp98VGFYSUlVe8ocfhawLt5I/io8BFbd
        bn3AZ6HkyY9CGc3BX3IfJB4KLayo9UcRA5wi0SRdxMvVbAihRkT+5+4wharpuLLBonsHo3lNuOebL
        eLwsZyuKc3wucy0ZJhz9PyXWdRrC5oEQz4YnZCgvqMTKg8CXCm3sVjSjnBsDH0zoAomNkbIUDflmp
        uxT2rXTr2bHyLQVAHelqvlb3myffkW02GYaAL2Ak1qo7o4wP/KaNZ5IcypBXTTUDCXVWUhTDUqoJS
        DAdg1g8g==;
Received: from [2601:1c0:6280:3f0::cf3b]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l9B1Q-0004Bq-TI; Mon, 08 Feb 2021 18:12:29 +0000
Subject: Re: [PATCH V2] include: linux: spi: Change provied to provided in the
 file spi.h
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, broonie@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210208114928.32241-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6da5b770-e5d5-1994-12e8-7654493cae82@infradead.org>
Date:   Mon, 8 Feb 2021 10:12:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210208114928.32241-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 2/8/21 3:49 AM, Bhaskar Chowdhury wrote:
> 
> s/provied/provided/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

OK.

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
> Changes from V1:
>   As Mark pointed out change provide to provided for the context
> 
>  include/linux/spi/spi.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index aa09fdc8042d..79f89fd250de 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -624,7 +624,7 @@ struct spi_controller {
> 
>  	/*
>  	 * These hooks are for drivers that use a generic implementation
> -	 * of transfer_one_message() provied by the core.
> +	 * of transfer_one_message() provided by the core.
>  	 */
>  	void (*set_cs)(struct spi_device *spi, bool enable);
>  	int (*transfer_one)(struct spi_controller *ctlr, struct spi_device *spi,
> --
> 2.20.1
> 


-- 
~Randy

