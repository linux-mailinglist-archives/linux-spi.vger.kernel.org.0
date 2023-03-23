Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E426C6EF4
	for <lists+linux-spi@lfdr.de>; Thu, 23 Mar 2023 18:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbjCWRb3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 23 Mar 2023 13:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbjCWRbX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 23 Mar 2023 13:31:23 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B37E28E7A
        for <linux-spi@vger.kernel.org>; Thu, 23 Mar 2023 10:31:17 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id bt19so89161pfb.3
        for <linux-spi@vger.kernel.org>; Thu, 23 Mar 2023 10:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679592677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6kiM2lrh2kvgdALZI8OIkWyLB50SqdxAm52tOpr2esY=;
        b=HXiP72pym+YYw/orvrMjuH/G76artp0TTfq7fhSlUPoJldbPdKxo3MqETM7XoMrCX/
         5MljJsHVpAL1rPPYKJFros7D3ckXNFp7LvANq7FzWMN8EXqeau3FUOkkmfu430yNwGtk
         rNzLOsjj27FpxdgtXZE5PmSLTxs0yAK+PEzT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679592677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6kiM2lrh2kvgdALZI8OIkWyLB50SqdxAm52tOpr2esY=;
        b=19EQj9Pa/ICrtROHHylSFZNdCotcFR5ptZyF5gwlpgXV7abydwyp8QunSaXV9IcdJ1
         HBs2TN5dW1nKk72R9fsts7UX3RNBkRr+OjA9UWOT0dvZ7Kzysw55s6lZJ82hxB60S07c
         I4ntrUzR/s6shyLU73aeDd4iXjqFwlbHabJQc8FrGdU74Va6XMSfybFXxhxg9cqT7n69
         Tkh6yKCaR9kph/neZJo+w0nkUg1iwXnp6hD9WJmHIhqRRXnQtngv9c2IwEL793WVxQl9
         g2U9D3b5bQbHHV2Wfs3rdz0W0pzQb/kwSy8jO9qOwEQZ5ZZAcOQaCo41uu8yFQRPVbMw
         u0cw==
X-Gm-Message-State: AAQBX9elvyR7R/i8FhwsdfgtesC/zDTmqiARXg2vEHKAb+TranhDHwxv
        qymph7Pp3nBsr3V07Q9B/bnmfQ==
X-Google-Smtp-Source: AKy350buG3y4PZg93OsVSfDc5+NHl/qYArOkaLVdvFImYeKdyz7hN2Fv645vPTrSh6BE5heW32nH9g==
X-Received: by 2002:a62:8413:0:b0:624:d72e:e629 with SMTP id k19-20020a628413000000b00624d72ee629mr251075pfd.8.1679592676912;
        Thu, 23 Mar 2023 10:31:16 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:16d3:ef20:206a:6521])
        by smtp.gmail.com with ESMTPSA id x13-20020a62fb0d000000b0061a6f4c1b2bsm12613546pfm.171.2023.03.23.10.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 10:31:15 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-gpio@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 04/14] arm64: dts: qcom: sc7180: Annotate l13a on trogdor to always-on
Date:   Thu, 23 Mar 2023 10:30:08 -0700
Message-Id: <20230323102605.4.I9f47a8a53eacff6229711a827993792ceeb36971@changeid>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
In-Reply-To: <20230323173019.3706069-1-dianders@chromium.org>
References: <20230323173019.3706069-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The l13a rail on trogdor devices has always been intended to be
always-on on both S0 and S3. Different trogdor variants use l13a in
slightly different ways, but the overall theme is that it's a 1.8V
rail that the board uses for things that it wants powered in on S0 and
S3. On many boards this includes the boot SPI (AKA qspi).

For all intents and purposes this patch is actually a no-op since
something else in the system seems to already be keeping the rail on
all the time (confirmed via multimeter). That "something else" was
postulated to be the modem but the rail is on / stays on even without
the modem/wifi coming up so it's likely the boot config. In any case,
making the fact that this is always-on explicit seems like a good
idea.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index 423630c4d02c..1f2e1f701761 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -512,6 +512,8 @@ pp1800_l13a: ldo13 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
+			regulator-boot-on;
 		};
 
 		pp1800_prox:
-- 
2.40.0.348.gf938b09366-goog

