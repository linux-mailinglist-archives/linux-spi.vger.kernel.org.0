Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12A875FB68
	for <lists+linux-spi@lfdr.de>; Mon, 24 Jul 2023 18:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjGXQEA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 Jul 2023 12:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjGXQD6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 24 Jul 2023 12:03:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03E910D8;
        Mon, 24 Jul 2023 09:03:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60E6F6123E;
        Mon, 24 Jul 2023 16:03:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D206C433C9;
        Mon, 24 Jul 2023 16:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690214636;
        bh=gEGG+FZYD+NSA0ZYzDRF7T5qT2Xr+u4huds8czcmYno=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ardLAL214iDLsUNo193xmbUiA3sADMAWpXdYMa57c0a/IH8keZh98mM8kjpbzgl4v
         l4XH3FwUPyzKGO7w6ZzTjEYw3+T9g5CkLhUl8Kt65qHlEd83LW41Vr5cQeBO3a4j6/
         FURIr/prACokPQeMqTEZL4jIDE6ETrJsD3WdrG6/M5fMu+kTUKWxfgHIgPltp5bjG1
         QWfRMVv/jySJzXpUZwNtqxN5u66tIbwwzFa1XwrRzQWBbniuE9cGVBD6Pybjyfj3Dh
         7rqhktMl3zHsxESmWx9O7cKM/VpIWWixtzAM0HbUsEmp+wEEpFwfv8wPFdi68g1Mxk
         1P9Q4Kqyx7eYw==
Received: (nullmailer pid 3627162 invoked by uid 1000);
        Mon, 24 Jul 2023 16:03:54 -0000
Date:   Mon, 24 Jul 2023 10:03:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org, Ming Qian <ming.qian@nxp.com>,
        Shijie Qin <shijie.qin@nxp.com>,
        Zhou Peng <eagle.zhou@nxp.com>, linux-spi@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>
Subject: Re: [PATCH 2/3] dt-bindings: lpspi: Add power-domains
Message-ID: <169021463363.3627105.7699659264255868174.robh@kernel.org>
References: <20230721111020.1234278-1-alexander.stein@ew.tq-group.com>
 <20230721111020.1234278-2-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721111020.1234278-2-alexander.stein@ew.tq-group.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On Fri, 21 Jul 2023 13:10:19 +0200, Alexander Stein wrote:
> i.MX8(X) based SoC use a power domain. Allow supplying this domain in
> bindings.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

