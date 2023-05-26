Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F111C712817
	for <lists+linux-spi@lfdr.de>; Fri, 26 May 2023 16:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236978AbjEZOM4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 26 May 2023 10:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237404AbjEZOM4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 26 May 2023 10:12:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445CE116
        for <linux-spi@vger.kernel.org>; Fri, 26 May 2023 07:12:55 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1q2YBT-0002BH-EV; Fri, 26 May 2023 16:12:47 +0200
Message-ID: <dd601c80-87dc-c032-4b75-5ac368981f64@pengutronix.de>
Date:   Fri, 26 May 2023 16:12:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] spi: imx: correct handling of MXC_CSPIRXDATA value
 endianness
Content-Language: en-US
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     Simon Horman <horms@kernel.org>, Mark Brown <broonie@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     jiada wang <jiada_wang@mentor.com>, linux-spi@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
References: <20230526-spi-imx-endian-v1-1-98d4d4ef4afc@kernel.org>
 <d29db298-0484-ea6f-3554-fa02b3a077dd@pengutronix.de>
In-Reply-To: <d29db298-0484-ea6f-3554-fa02b3a077dd@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 26.05.23 16:09, Ahmad Fatoum wrote:
>> -	writel(val, spi_imx->base + MXC_CSPITXDATA);
>> +	__raw_writel((__force u32)cpu_to_be32(val),
>> +		     spi_imx->base + MXC_CSPITXDATA);
>>  }

On more thing: __raw_writel doesn't involve a write barrier (at least
on ARM). That means above code introduces a bug as the CPU may now reorder
writes that were sequential before. Both iowrite32be() and readl()
have a __iowmb(); on ARM before doing the write itself.

>>  
>>  /* MX51 eCSPI */
>>
>>
>>
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

