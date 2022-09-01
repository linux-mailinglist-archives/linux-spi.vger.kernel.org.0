Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210565A9B6D
	for <lists+linux-spi@lfdr.de>; Thu,  1 Sep 2022 17:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbiIAPUF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Sep 2022 11:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234009AbiIAPUB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Sep 2022 11:20:01 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FD4E01A
        for <linux-spi@vger.kernel.org>; Thu,  1 Sep 2022 08:19:54 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id r22so16683797pgm.5
        for <linux-spi@vger.kernel.org>; Thu, 01 Sep 2022 08:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :organization:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date;
        bh=cXtEOviGl20sElmqYhk+5qGF+uRCZLPH81qK6/o7kKg=;
        b=nTYbQ7jQyDbc60uXx8se0yBtjfhiWhYxa9/EBIhVWfosqTcg72OzhquZanqSOFo+HK
         qlAP75+0jE4nWEgu9J9175tnNXEeVTjDNwh1aVGun0rm7LDJg9O6+vZOSW81ypmmJvVg
         wtoiSwUVWtpLfCAilLG2pZLeJ5Jt0U+Xuv9K+NeFTjjdwGc3R97Qsf5aaBdCIaoANV/W
         xshaie1aIE7ziqHInVkQ9JBtBVZPCVC8Rsodu5XXVz2lxPjYu/M4//BrcdYfQs235QxG
         5Gy0r5eCQvMeMDhh/grTsxi5375nwhdafoI8/YnUKUGl6Qr0FkTGZ8Zg0bQyYIx7ZlW+
         Z3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :organization:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=cXtEOviGl20sElmqYhk+5qGF+uRCZLPH81qK6/o7kKg=;
        b=voPseJSZ9CxhO8pWdRrWb3WI6AIFhTZ4JagUcQT1t+2TZddsAqJysIVI/noNMtiXsY
         GsCsh/lk599tDhQJLxkWE3RAROsTWvviMAUGMzLyLy0WnSHB/HsUvCcmfs2W4c+c6ivm
         xgC8MtiSJJqBIH0Yg+RuAK9+UTpBi8jOW0QSEYffGYR8EMxaXffkwC12HzCcT0fc4zjd
         5kGwEHAdLH/AbgieiULIJBcjteE8AtL5nGAFAe9jIUIH2oF+GhSd87q+9ePgCOv7v0tD
         gO0FifkC5PqU5ifPDmCzepzkfwEnzQng7XVk8W0HToq9Ij8rJyGNvnt0Rzz6MTurEE1s
         5g4g==
X-Gm-Message-State: ACgBeo1eaVMNyZtwrqHP6eaY/efnkKB5a1i07F4Z4Nce5GhSI63HDNYF
        8aoJa/zyQPD0UZ8I0eV/G+N8eGrM96o=
X-Google-Smtp-Source: AA6agR7nQzQzR+Di4M2B6P61F7nxLaSBnk68rM5DwOjpbEQ2yB+L0/suPzxH/vQxyHvM4SXRAALqtA==
X-Received: by 2002:a63:3204:0:b0:42b:40b9:bfc4 with SMTP id y4-20020a633204000000b0042b40b9bfc4mr26748764pgy.357.1662045593562;
        Thu, 01 Sep 2022 08:19:53 -0700 (PDT)
Received: from wse-c0155 (static-193-12-47-89.cust.tele2.se. [193.12.47.89])
        by smtp.gmail.com with ESMTPSA id w131-20020a627b89000000b00537dfd6e67esm11855610pfc.48.2022.09.01.08.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 08:19:53 -0700 (PDT)
Date:   Thu, 1 Sep 2022 17:19:45 +0200
From:   Casper Andersson <casper.casan@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     David Jander <david@protonic.nl>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH v1] spi: mux: Fix mux interaction with fast path
 optimisations
Message-ID: <20220901151945.vqav4qknlrguyors@wse-c0155>
Organization: Westermo Network Technologies AB
References: <20220901120732.49245-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901120732.49245-1-broonie@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

This does indeed solve my problems. Thank you!

Tested-by: Casper Andersson <casper.casan@gmail.com>

On 2022-09-01 13:07, Mark Brown wrote:
> The spi-mux driver is rather too clever and attempts to resubmit any
> message that is submitted to it to the parent controller with some
> adjusted callbacks.  This does not play at all nicely with the fast
> path which now sets flags on the message indicating that it's being
> handled through the fast path, we see async messages flagged as being on
> the fast path.  Ideally the spi-mux code would duplicate the message but
> that's rather invasive and a bit fragile in that it relies on the mux
> knowing which fields in the message to copy.  Instead teach the core
> that there are controllers which can't cope with the fast path and have
> the mux flag itself as being such a controller, ensuring that messages
> going via the mux don't get partially handled via the fast path.
> 
> This will reduce the performance of any spi-mux connected device since
> we'll now always use the thread for both the actual controller and the
> mux controller instead of just the actual controller but given that we
> were always hitting the slow path anyway it's hopefully not too much of
> an additional cost and it allows us to keep the fast path.
> 
> Fixes: ae7d2346dc89 ("spi: Don't use the message queue if possible in spi_sync")
> Reported-by: Casper Andersson <casper.casan@gmail.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  drivers/spi/spi-mux.c   | 1 +
>  drivers/spi/spi.c       | 2 +-
>  include/linux/spi/spi.h | 2 ++
>  3 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-mux.c b/drivers/spi/spi-mux.c
> index f5d32ec4634e..0709e987bd5a 100644
> --- a/drivers/spi/spi-mux.c
> +++ b/drivers/spi/spi-mux.c
> @@ -161,6 +161,7 @@ static int spi_mux_probe(struct spi_device *spi)
>  	ctlr->num_chipselect = mux_control_states(priv->mux);
>  	ctlr->bus_num = -1;
>  	ctlr->dev.of_node = spi->dev.of_node;
> +	ctlr->must_async = true;
>  
>  	ret = devm_spi_register_controller(&spi->dev, ctlr);
>  	if (ret)
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 83da8862b8f2..c4ccd45ebc1a 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -4033,7 +4033,7 @@ static int __spi_sync(struct spi_device *spi, struct spi_message *message)
>  	 * guard against reentrancy from a different context. The io_mutex
>  	 * will catch those cases.
>  	 */
> -	if (READ_ONCE(ctlr->queue_empty)) {
> +	if (READ_ONCE(ctlr->queue_empty) && !ctlr->must_async) {
>  		message->actual_length = 0;
>  		message->status = -EINPROGRESS;
>  
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index e6c73d5ff1a8..f089ee1ead58 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -469,6 +469,7 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
>   *	SPI_TRANS_FAIL_NO_START.
>   * @queue_empty: signal green light for opportunistically skipping the queue
>   *	for spi_sync transfers.
> + * @must_async: disable all fast paths in the core
>   *
>   * Each SPI controller can communicate with one or more @spi_device
>   * children.  These make a small bus, sharing MOSI, MISO and SCK signals
> @@ -690,6 +691,7 @@ struct spi_controller {
>  
>  	/* Flag for enabling opportunistic skipping of the queue in spi_sync */
>  	bool			queue_empty;
> +	bool			must_async;
>  };
>  
>  static inline void *spi_controller_get_devdata(struct spi_controller *ctlr)
> 
> base-commit: b90cb1053190353cc30f0fef0ef1f378ccc063c5
> -- 
> 2.30.2
> 
