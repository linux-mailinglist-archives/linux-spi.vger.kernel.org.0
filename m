Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 894711520CF
	for <lists+linux-spi@lfdr.de>; Tue,  4 Feb 2020 20:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbgBDTMK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 4 Feb 2020 14:12:10 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:56262 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbgBDTMK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 4 Feb 2020 14:12:10 -0500
Received: by mail-pj1-f68.google.com with SMTP id d5so1801299pjz.5
        for <linux-spi@vger.kernel.org>; Tue, 04 Feb 2020 11:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uFqUZvbEKYLNXxdPtvXaq5M8MJ+i8vwd9UYeLfuQUDA=;
        b=HhzCmrYB32A8vt5zVLleIdlmYlky91/IeL3Lk6ezKsBu8iHqwAGGlMHWIBrs7nCL5P
         N6iTg8JbNeGLBKxYKa21ffo9vqKuutlJarWAxQrTv/PYw0HNxX8K1RF0q+BtV6kqszI+
         /FVsmU6AULdSSOFeilEEFmG/qWKMFPLXWqGGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uFqUZvbEKYLNXxdPtvXaq5M8MJ+i8vwd9UYeLfuQUDA=;
        b=Ea+RkyRH5a1Fu5/Jo9QHIYdBajVNhc8X9todi1EvekJEO9xgXYSmMOUX8QzWQLGQW9
         Y6K44zGIEllQGFnbxAxlZUb4XLeseOF9LlmPb8PRQJOPyV6dtUQL3Gdi7UXyMHrz55Nr
         HKyyXlRZWm1L4ItRI8dkjFuplo1msQLWiuxegD6WRM4foNRpds48Jkn51wksD63BhhtR
         KSqu/AxN+2aJm66RyZuKXs1gCNe/Sde9+X3C80JurpxwXLXvgL+KZOCKgOO6HoI5ZlaX
         lFmLkqNsIbwnuNfdLDCJgRxeO83VQZzvQ0/M+FFxxPk3Q2ITRFMxTK2YUI8XAQKmBuqq
         CY/A==
X-Gm-Message-State: APjAAAWY/+qxBCMn3PBiyzzvNQJQypr3BM6/eHJG75SQDE8LZnjzFzkr
        zCYcvugNEcCoDL93vWfU0MJCQ/CbR/Rpew==
X-Google-Smtp-Source: APXvYqyPRzVjhfVocnOGfHHdfLcQSJdIKvNNnAHNb2zia8JuTkMtKWO8HiAmdbjprVW7uwaxJsbvzg==
X-Received: by 2002:a17:90b:f0f:: with SMTP id br15mr719255pjb.138.1580843528132;
        Tue, 04 Feb 2020 11:12:08 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id c19sm26303229pfc.144.2020.02.04.11.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 11:12:07 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-spi@vger.kernel.org
Subject: [PATCH 0/3] Misc qcom geni spi driver fixes
Date:   Tue,  4 Feb 2020 11:12:03 -0800
Message-Id: <20200204191206.97036-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Here's a small collection of qcom geni spi driver fixes that
simplify the code and aid debugging.

Stephen Boyd (3):
  spi: spi-geni-qcom: Let firmware specify irq trigger flags
  spi: spi-geni-qcom: Grow a dev pointer to simplify code
  spi: spi-geni-qcom: Drop of.h include

 drivers/spi/spi-geni-qcom.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

-- 
Sent by a computer, using git, on the internet

