Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C62C337E09
	for <lists+linux-spi@lfdr.de>; Thu, 11 Mar 2021 20:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbhCKTW3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Mar 2021 14:22:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbhCKTVy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 11 Mar 2021 14:21:54 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9C9C061574;
        Thu, 11 Mar 2021 11:21:54 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id k9so41607308lfo.12;
        Thu, 11 Mar 2021 11:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uvJsQOP1p7E9AffUBE2QJK2LpjrpqogJTnHjdmlAy3g=;
        b=AUzo78cMdsJJJhGMTgl8WEDo8UZcgsgRLS0Yrs3VHylHmn638Xd0SAmqI/iOnJbWSm
         ra6zNdyXsoQnp0pdaJ/2AJ+T2f1vxGN7nkfcyzC7lnVdgVqe6j3PeF83K9+mRN7lCkKF
         hQAq0EPSrB3u3utzKBpo32mTaZpxpncfzYqtxGLU1AZ9wDs6a+iUwi3/tM/THbo/ZDAN
         xgEZOlxDMPiB0d0auUpg8aYp4Qwd6tjWO3N9l7/0IolDJz5q2IH9RlTR1XQDHY7RfC0b
         zEx5c6UR/WdmgjlHVlAyXchnUUOiwUpQuyG21mOoptBg6CEVwXiQ26Urb5leOWVJKlXQ
         Z0Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uvJsQOP1p7E9AffUBE2QJK2LpjrpqogJTnHjdmlAy3g=;
        b=DuBJSK63xfLGvuP+8DvJ87HH7+Ob70MHt66wOw66eJ49GQw4IfcvWz08mXSHkgF3Jx
         +fIu2XxLoPYY+mzQphKc7jUg66E63pWTFNlV0lLKCVdeaxJ2uSraaE13BaiIq3h+TsS8
         /k9zsFANjfBTozbiIEQkGpFGhcuta6zgRBx+Vef8nI9L1lVGfNkRwNrmnmg1nKr+JcZD
         YLvcA1kLACfK8BksR1JelwPJH1kwZNabbATBb/SRyVnpbhIzsxZfo/qu/UYg6ZCh+3lr
         fmbLDx60+l+dGVoKTRK9nicmH3IKJszZ7Qq93Q5rXrdqq9ydUpyweTk9DRmUvST5Otge
         WJgw==
X-Gm-Message-State: AOAM533ygs+XnK5JoxQylVBTkQtoTQA0aI/5RDrpqTrW933XM+qgDtq4
        nksPTQ3Nv5csvG4xocy7DUg=
X-Google-Smtp-Source: ABdhPJwW9M4QeeMi8R8HV+0T6eXqDdFannBfc6ezCO7f5Qrvj5lHmCCOXOavy0TnJcIgzJWLxaLzHw==
X-Received: by 2002:a05:6512:2212:: with SMTP id h18mr3101616lfu.330.1615490512780;
        Thu, 11 Mar 2021 11:21:52 -0800 (PST)
Received: from localhost.localdomain (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.gmail.com with ESMTPSA id u14sm1121153lfl.40.2021.03.11.11.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 11:21:52 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Qiang Yu <yuq825@gmail.com>, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Yangtao Li <tiny.windzz@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
        lima@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-media@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v2 13/14] media: venus: Convert to use resource-managed OPP API
Date:   Thu, 11 Mar 2021 22:21:04 +0300
Message-Id: <20210311192105.14998-14-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210311192105.14998-1-digetx@gmail.com>
References: <20210311192105.14998-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

Use resource-managed OPP API to simplify code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/media/platform/qcom/venus/pm_helpers.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index 43c4e3d9e281..14fa27f26a7d 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -860,45 +860,33 @@ static int core_get_v4(struct device *dev)
 	if (legacy_binding)
 		return 0;
 
-	core->opp_table = dev_pm_opp_set_clkname(dev, "core");
+	core->opp_table = devm_pm_opp_set_clkname(dev, "core");
 	if (IS_ERR(core->opp_table))
 		return PTR_ERR(core->opp_table);
 
 	if (core->res->opp_pmdomain) {
-		ret = dev_pm_opp_of_add_table(dev);
+		ret = devm_pm_opp_of_add_table(dev);
 		if (!ret) {
 			core->has_opp_table = true;
 		} else if (ret != -ENODEV) {
 			dev_err(dev, "invalid OPP table in device tree\n");
-			dev_pm_opp_put_clkname(core->opp_table);
 			return ret;
 		}
 	}
 
 	ret = vcodec_domains_get(dev);
-	if (ret) {
-		if (core->has_opp_table)
-			dev_pm_opp_of_remove_table(dev);
-		dev_pm_opp_put_clkname(core->opp_table);
+	if (ret)
 		return ret;
-	}
 
 	return 0;
 }
 
 static void core_put_v4(struct device *dev)
 {
-	struct venus_core *core = dev_get_drvdata(dev);
-
 	if (legacy_binding)
 		return;
 
 	vcodec_domains_put(dev);
-
-	if (core->has_opp_table)
-		dev_pm_opp_of_remove_table(dev);
-	dev_pm_opp_put_clkname(core->opp_table);
-
 }
 
 static int core_power_v4(struct device *dev, int on)
-- 
2.29.2

