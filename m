Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE92765DB9
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jul 2023 23:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjG0VHK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Jul 2023 17:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjG0VHJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 Jul 2023 17:07:09 -0400
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726B22D5B
        for <linux-spi@vger.kernel.org>; Thu, 27 Jul 2023 14:07:08 -0700 (PDT)
Received: from localhost (88-113-24-87.elisa-laajakaista.fi [88.113.24.87])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTP
        id 8a0d0197-2cc1-11ee-abf4-005056bdd08f;
        Fri, 28 Jul 2023 00:07:05 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Fri, 28 Jul 2023 00:07:05 +0300
To:     Minjie Du <duminjie@vivo.com>
Cc:     Vladimir Oltean <olteanv@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        "open list:FREESCALE DSPI DRIVER" <linux-spi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:PTP HARDWARE CLOCK SUPPORT" <netdev@vger.kernel.org>,
        opensource.kernel@vivo.com
Subject: Re: [PATCH v2] spi: fsl-dspi: Use dev_err_probe() in
 dspi_request_dma()
Message-ID: <ZMLcefaxpRVgkPyd@surfacebook>
References: <20230725035038.1702-1-duminjie@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725035038.1702-1-duminjie@vivo.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Tue, Jul 25, 2023 at 11:50:37AM +0800, Minjie Du kirjoitti:
> It is possible for dma_request_chan() to return EPROBE_DEFER, which means
> dev is not ready yet.
> At this point dev_err() will have no output.

...

>  	if (IS_ERR(dma->chan_tx)) {

> -		dev_err(dev, "tx dma channel not available\n");
>  		ret = PTR_ERR(dma->chan_tx);
> +		dev_err_probe(dev, ret, "tx dma channel not available\n");

It can be even simpler

		ret = dev_err_probe(dev, PTR_ERR(dma->chan_tx), "tx dma channel not available\n");

>  		goto err_tx_channel;
>  	}

-- 
With Best Regards,
Andy Shevchenko


