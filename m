Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F2C4D1CDA
	for <lists+linux-spi@lfdr.de>; Tue,  8 Mar 2022 17:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348217AbiCHQLo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Mar 2022 11:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348216AbiCHQLh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 8 Mar 2022 11:11:37 -0500
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61829506FD;
        Tue,  8 Mar 2022 08:10:40 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id 12so19322878oix.12;
        Tue, 08 Mar 2022 08:10:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OH0isBduUH3WTRoeg8Y2W/90hAKfYzpVVQwy9vayo7Y=;
        b=ex3EGStq+Q8PhrAgZsXaL16nFp6fTGsLj8fEL460fSVCb82ZMl4azE+Ov8MDtN4F2z
         buugqVJL87R06RN/Qfle63zqOORIdpMYLlzCVC4rbQ+BUkpsPyEXOsXAsrCCkg/QqQQ2
         sLPqUZ2XA6Kifr2GaVj4xgxxH12Yd7YEqxSG5t3F9/8J9xG8ksJQxlUW0ipsvovtUwfg
         VKRlHGSSvyQ74sp/p2+eC5S6lmXuyOv16hL83aRIJ8MGT0oMIPSnC7XUKd20I6T8FtLs
         gI1D5R88V4YXKajWzilwioWrGl7zLPin+XSuas6G7x06HoUcxJIDnOiDo41oLcJjbk31
         POsw==
X-Gm-Message-State: AOAM533ZVhZPPZXT1uqa/X8k5q/iXhyRHnOrd6a/w7EyW9PJYtN9EbHu
        AQCbW9GtwAPJ0xYIUI1Oqw==
X-Google-Smtp-Source: ABdhPJzsHFznjPr/PNhN2YiTdX8wtONctQgQstVmvlEScy+khuCdoqBSidc9onO7JZ0i5C6cDYMF9Q==
X-Received: by 2002:aca:1c18:0:b0:2da:17d9:c02c with SMTP id c24-20020aca1c18000000b002da17d9c02cmr1664683oic.264.1646755839551;
        Tue, 08 Mar 2022 08:10:39 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 45-20020a9d08b0000000b005b2387fefb2sm2502313otf.78.2022.03.08.08.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 08:10:38 -0800 (PST)
Received: (nullmailer pid 851144 invoked by uid 1000);
        Tue, 08 Mar 2022 16:10:37 -0000
Date:   Tue, 8 Mar 2022 10:10:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mesih Kilinc <mesihkilinc@gmail.com>,
        devicetree@vger.kernel.org, Samuel Holland <samuel@sholland.org>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        linux-spi@vger.kernel.org,
        George Hilliard <thirtythreeforty@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>, linux-sunxi@lists.linux.dev,
        Maxime Ripard <mripard@kernel.org>,
        Jesse Taube <mr.bossman075@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: Re: [PATCH 10/14] dt-bindings: spi: sunxi: document F1C100
 controllers
Message-ID: <Yid//bRBwVSaOhA0@robh.at.kernel.org>
References: <20220307143421.1106209-1-andre.przywara@arm.com>
 <20220307143421.1106209-11-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307143421.1106209-11-andre.przywara@arm.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 07 Mar 2022 14:34:17 +0000, Andre Przywara wrote:
> The Allwinner F1C100 series contains two SPI controllers, which are
> compatible to the IP block used in the Allwinner H3 as well.
> The only difference in the integration is the missing mod clock in the
> F1C100, but that does not affect the SPI controller binding, as we can
> still supply the correct clock (AHB parent) easily.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  .../devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml         | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
