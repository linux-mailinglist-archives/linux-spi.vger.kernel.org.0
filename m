Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC98201FB6
	for <lists+linux-spi@lfdr.de>; Sat, 20 Jun 2020 04:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731773AbgFTCWi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 19 Jun 2020 22:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731752AbgFTCWh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 19 Jun 2020 22:22:37 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34E8C0613EE
        for <linux-spi@vger.kernel.org>; Fri, 19 Jun 2020 19:22:35 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a45so4968630pje.1
        for <linux-spi@vger.kernel.org>; Fri, 19 Jun 2020 19:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ILpDZ3g9RyhdCAmxH0qmTrsO+2Jv0SpzLTozx8GBn9c=;
        b=OHvft9pwOa/GYAdCFYxEz/NDExYtwokXsA2ThVXvvC3L2llsk0L4ygM7PglBrxfIlE
         riFeZNNFAFupw6qQDwIIFWO6oPyZGY/dkGSLo3f4KkqWwjn+WiMhqJ/jiUH/CDtHPtdW
         n4IKkbw8AENTUmfEVOtroQunniMAyN5lsqy9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ILpDZ3g9RyhdCAmxH0qmTrsO+2Jv0SpzLTozx8GBn9c=;
        b=V4mGNCu8rSBmGJVP+UzxklkOdWlCyfZqWHJmFNGClgJuYZ6gRcC7f/UyiLSuQQLEMG
         6GhSPtPlp4MmpyWI9PdyKjldsCyGxjz0v8lgA7xwr3t2PWaRv0+SIEyM1AeKa5/nzKXk
         +xhHWFlE23+G4CW7UYGgwsu6u6I7CWCasuYe8djinNqSLE1O37vXhUb8As2+FoB5SwAi
         xnb//7X8XP2L6YOp6qPOspCvGiW12B9zv0b6a0cCSVguUgg9xAuQ3csuIKHFn2QOpzmz
         Y3pZkgpT8uA8PQotGW0MIfSV11O7tcpweEx7/04Rv/XUn0TwtKjn9sTGLPLPk5UHvNyG
         m8lQ==
X-Gm-Message-State: AOAM532PYK2Eb3mszOdmSP9OI81964AJzbh0wVImPYUQSHnxdRQvF1UX
        jrN5wXm8mtV2boLQZFH3pEjqVg==
X-Google-Smtp-Source: ABdhPJya2OjomlPpqTqbnSJht2OJvzEboztD2rUElEBmRBsqZobnQJMGxhW2DXb5CZF39tXbToWriw==
X-Received: by 2002:a17:90a:c717:: with SMTP id o23mr6365885pjt.195.1592619755094;
        Fri, 19 Jun 2020 19:22:35 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id m14sm6241911pjv.12.2020.06.19.19.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 19:22:34 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Alok Chauhan <alokc@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v1 0/2] Some small spi geni cleanups
Date:   Fri, 19 Jun 2020 19:22:31 -0700
Message-Id: <20200620022233.64716-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

To follow onto Doug's latest spi geni series[1] this simplifies and
reduces the code a little more.

[1] https://lore.kernel.org/r/20200618150626.237027-1-dianders@chromium.org

Stephen Boyd (2):
  spi: spi-geni-qcom: Simplify setup_fifo_xfer()
  spi: spi-geni-qcom: Don't set {tx,rx}_rem_bytes unnecessarily

 drivers/spi/spi-geni-qcom.c | 55 +++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 30 deletions(-)


base-commit: 7ba9bdcb91f694b0eaf486a825afd9c2d99532b7
-- 
Sent by a computer, using git, on the internet

