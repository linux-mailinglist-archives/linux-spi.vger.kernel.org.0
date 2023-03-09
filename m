Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8AF76B2249
	for <lists+linux-spi@lfdr.de>; Thu,  9 Mar 2023 12:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbjCILIc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 Mar 2023 06:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbjCILH4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 9 Mar 2023 06:07:56 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D133EF5D0E
        for <linux-spi@vger.kernel.org>; Thu,  9 Mar 2023 03:01:56 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9A7B86603012;
        Thu,  9 Mar 2023 11:01:45 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678359706;
        bh=WH7TIFE7GrzDsTCUc9cs7HLmmMuya/jcFwA084XwdQY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=A5I2X787Xscvt2B1AlGBb7FlhcwxGmjpGVffMNNJNwSIntMJlP+Rm7B2u2+1P40cU
         LLopXZ5GyjMHEeMOGuuH0H9aSjw07ZV++ighGMf8lzkMXvEWijGDJRMTCuTjot+45P
         LiI/f0fJxQ1ACQtJp8fmKgziBRTVJUH2jvIktmaKt6z5ALYV9XIoxoXICSpqdJigLO
         PH/11SSnLShIGOYANDf5kqfyXfVojLhJVn0VKbm8Va9Z8Pr6zhclHRW0TE53YuDHMD
         +w7AJgFfMNGhSdhOwLPFoNgWmhBVmVaUXm0Le29/FHcagilMXPFA9AUKZpYofktqJR
         zGznBeEINeWCQ==
Message-ID: <9d62f04f-1d3c-e892-58dc-b20e6162dbb4@collabora.com>
Date:   Thu, 9 Mar 2023 12:01:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 3/3] spi: mt65xx: Don't disguise a "return 0" as "return
 ret"
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230309094704.2568531-1-u.kleine-koenig@pengutronix.de>
 <20230309094704.2568531-4-u.kleine-koenig@pengutronix.de>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230309094704.2568531-4-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Il 09/03/23 10:47, Uwe Kleine-König ha scritto:
> Because of the earlier
> 
> 	 if (ret)
> 		return ret;
> 
> ret is always zero at the end of mtk_spi_suspend(). Write it as explicit
> return 0 for slightly improved clearness.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


