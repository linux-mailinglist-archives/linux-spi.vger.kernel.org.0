Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D54594B4F
	for <lists+linux-spi@lfdr.de>; Tue, 16 Aug 2022 02:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351825AbiHPAOj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Aug 2022 20:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357265AbiHPANS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Aug 2022 20:13:18 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40C617651C
        for <linux-spi@vger.kernel.org>; Mon, 15 Aug 2022 13:29:53 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id s11-20020a1cf20b000000b003a52a0945e8so4426606wmc.1
        for <linux-spi@vger.kernel.org>; Mon, 15 Aug 2022 13:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Xr+UfO+qh4isF9IlG5bCz7LtZXBHMAXoplA9/7WZzXo=;
        b=W4xaU/BQRB9QDvjZod3/K3AWAoKIGLhJ9kSF6a1Iya5gjWDxGbWWn/dZ285MabIA9M
         ay2Id7daU2+BUbMKABA3ixnJor0fQfOk85SxhM22w47UmU/gksLCG4KajVtQfVRAvri7
         YkMbZ+/h+pF+dbho4ih9LjpsT6URElhZmiKctKEqOqehyEgr2Ew0L+uTpfy58iXpjCOm
         X3QIZwo2PtKT/6AldR1qYt/qgDL217r7mHpzBLNi8p1yyZd7pBF9XVyVoVKQWyVFY5yW
         Xk5ag8m8afmpc2Uipn/qL3gC55NG/b780t1nk9B0pVPxSREuswL5T6zhJ/5elaga/BX3
         iOPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Xr+UfO+qh4isF9IlG5bCz7LtZXBHMAXoplA9/7WZzXo=;
        b=JC3V7wBBpFHSU/h3/iqBgmh7N9/9apfxPkRI1v5ftGpz+qRd5AnNZPs2+acd49KPei
         qJgc7QgiCw/woXvcDKWHErMAfzxyE3o+ztwnhh4t5eJOYq6CE5re/alKoJrJw9jxZT5B
         pqKwkTWaCdxge4DDcwhOMf7L8qxQ9wdEoMoN5PUiWty19ttXZxWZ5cVJ10yCbVhqM9Tu
         4eTtMs7TD2DePcsA7ITg+7yp26dag32UO9Vcxud5ulw2w7lpB9rAflXvWCRCKu527ke7
         1JnXZIAPO7A4UQIvY43aJkeeFWMLEfCVR0CJXCCMNpbDmaOZcVUc7CSbXwEPTBQ9IL2n
         0Yaw==
X-Gm-Message-State: ACgBeo0n4eK2tJWxTds/WhEurUDNYOUqz4yqJPZrhy/kCxPT8KqKsPmm
        uDfjRRzFlo1IKpJ0UtL9EnXnlA==
X-Google-Smtp-Source: AA6agR7dfZyQkZTV2Qp0fB4jebLEk+ydPCl/oc9p/QV2VmrnbmA80BIWxTHmCnHaPLjxKiwjgswSig==
X-Received: by 2002:a1c:3b46:0:b0:3a5:a92d:9e62 with SMTP id i67-20020a1c3b46000000b003a5a92d9e62mr10852053wma.175.1660595391981;
        Mon, 15 Aug 2022 13:29:51 -0700 (PDT)
Received: from henark71.. ([109.76.58.63])
        by smtp.gmail.com with ESMTPSA id e10-20020adf9bca000000b0022515d9e2ddsm323905wrc.45.2022.08.15.13.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 13:29:51 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     conor.dooley@microchip.com, daire.mcnamara@microchip.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, broonie@kernel.org,
        nagasuresh.relli@microchip.com,
        valentina.fernandezalanis@microchip.com,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH] riscv: dts: microchip: add qspi compatible fallback
Date:   Mon, 15 Aug 2022 21:29:37 +0100
Message-Id: <166059535262.2709508.15329793193826864091.b4-ty@microchip.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220810085914.801170-1-conor.dooley@microchip.com>
References: <20220810085914.801170-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

On Wed, 10 Aug 2022 09:59:15 +0100, Conor Dooley wrote:
> The "hard" QSPI peripheral on PolarFire SoC is derived from version 2
> of the FPGA IP core. The original binding had no fallback etc, so this
> device tree is valid as is. There was also no functional driver for the
> QSPI IP, so no device with a devicetree from a previous mainline
> release will regress.
> 
> 
> [...]

Applied to dt-for-next, thanks!

[1/1] riscv: dts: microchip: add qspi compatible fallback
      https://git.kernel.org/conor/c/7eac0081a8e9

Thanks,
Conor.
