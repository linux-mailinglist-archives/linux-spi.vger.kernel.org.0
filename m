Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746D5715A0E
	for <lists+linux-spi@lfdr.de>; Tue, 30 May 2023 11:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjE3J1X (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 30 May 2023 05:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjE3J1C (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 30 May 2023 05:27:02 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B8111D
        for <linux-spi@vger.kernel.org>; Tue, 30 May 2023 02:25:59 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A9F1066059A8;
        Tue, 30 May 2023 10:25:57 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685438758;
        bh=KG2FKmtvB1+MNxod1QWQZiu9EnjhpMcneY/1oVshCL0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HVSgHlMbOPveawPIlUjfDLvRl/f6CnezYmLOWuppi/VfXQ2PGeF/vQu57v+UlxZmL
         IhKvQKkv+tBT0sQzvA5M7QqDHjT8yPQPBr/muBNhavEEqnlxRrKqGlGQ0qTH3MHIMo
         aw+6xVDefmIxvt2WN8N7mY99Y0NM0lJf5d4MVEMKgkTvY1PTILV0aYwrR0as5PSTdh
         1qNuQ3AREzKEInAbkoKVb/kDvyoxdd3js5sqXVKReq9x6VL8QTyhRST8dMGWaLPV4I
         mC1h9nivHS0g8FGP98id3CFHTVwNQDpMNjsTXW9ROV2PZg55GFHhC7HIRf5B7sz0Ad
         jHWQehUIOrp2Q==
Message-ID: <68f7d44b-1c89-c452-1585-03b1d209597f@collabora.com>
Date:   Tue, 30 May 2023 11:25:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 1/3] spi: mt65xx: Properly handle failures in .remove()
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-spi@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
References: <20230530081648.2199419-1-u.kleine-koenig@pengutronix.de>
 <20230530081648.2199419-2-u.kleine-koenig@pengutronix.de>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230530081648.2199419-2-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Il 30/05/23 10:16, Uwe Kleine-König ha scritto:
> Returning an error code in a platform driver's remove function is wrong
> most of the time and there is an effort to make the callback return
> void. To prepare this rework the function not to exit early.
> 
> There wasn't a real problem because if pm runtime resume failed the only
> step missing was pm_runtime_disable() which isn't an issue.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Cheers!
