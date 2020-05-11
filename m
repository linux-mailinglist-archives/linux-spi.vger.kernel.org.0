Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA05C1CD126
	for <lists+linux-spi@lfdr.de>; Mon, 11 May 2020 06:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbgEKEyX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 May 2020 00:54:23 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:58345 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728447AbgEKExg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 11 May 2020 00:53:36 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 775DD31D;
        Mon, 11 May 2020 00:53:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 11 May 2020 00:53:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=8D8NJelTXQUt+y8GwfLHQxRi1C
        J86uY3Kb4mQLltkjw=; b=zgllr2/We9jSxleBcw1/2ntO2hUrSugVHY8sobNYiI
        HbYQxNlr2bs7gcpfKFsFT7G25mrKBIW7bhZoY1/gDpDhzxZ40IU0uYtt3VpblQzs
        HXjerXdr107XEOGeldKITEWDOYHMEgQeXZiozOc6v0a3YCHXVWYE6NKbXKHE4KT+
        T63+aX+EqNsCWdLHAd5HV3KyGVvG0DRaK0ynN6dmRqltIX/KJIO3KASszbYJ801N
        qsK9dPj21asjFYi8aLXIFLUmDNUuWZ/OrK5JsfwCxd5xfxYAxwdnPG7/rdShBIs/
        Ad0KOfwfmlUkoZTVQj/uy3Bf5XGWFahdQHRmnf9h6mhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=8D8NJelTXQUt+y8Gw
        fLHQxRi1CJ86uY3Kb4mQLltkjw=; b=lsRP5ghf6A2aa0OYp6Dq/fYECjUfzei3d
        v7JExSsAgGZND3KdvNmAVBFK92dDdyZySqiXfwsdwfhS7EWYgTJWNak9smsWq+Tc
        eX+O5t3Oneq9dNmQ3+7kd2LnVpMmKFiKfgKDct1PRUBlQkROFHKcywJwFtAEjjjn
        axXum50LzGpJ36ut77SDC/ZjS7Yju701bC+yZ+KXgSagt1rGmcG0REIcpa7IsplI
        spy2Nnl9LCncapLJRz6Z9GAuisZ39kF/aclitjfLFutFVOsK1N25G5JRdDSEWWzY
        OopTf6VNJ/EHaSNeQkrgI8EELv6MTqyNqMEhK/KzM4Z9ohtGnhizA==
X-ME-Sender: <xms:Tdq4Xp7hFnFA8RCNxMMjdMy6lY6Ai6a-stgC2CS8MhP20I0dFb5EHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrkeelgdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghirhes
    rghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepjeeliefhvdetgfdtte
    fhtdegffdtiefffeejiefffeevueeljeehjeevhfffueeknecukfhppeejfedrleefrdek
    gedrvddtkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:Tdq4XlUhq1SfSIi0Dog1rq1pXW9vvaDysx-oDCvZGsuGvxBm7_afUQ>
    <xmx:Tdq4XjE_-2z8D69JUQ7-KEqmV0cCeeLtiIPZCOYBYdWEAaSbVOcafA>
    <xmx:Tdq4XtcDYespdNQn6t2OCVTV5rOCfMpgdc0k_MLh4gBKZrY5QONaJQ>
    <xmx:Ttq4Xlg3sojeM94SUMQqTIyZesXdG6DZCFyPz7ktH0hj6K5Dzl7WQg>
Received: from alistair-xps-14z.alistair23.me (c-73-93-84-208.hsd1.ca.comcast.net [73.93.84.208])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1146F328005D;
        Mon, 11 May 2020 00:53:32 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     broonie@kernel.org, linux-spi@vger.kernel.org
Cc:     mripard@kernel.org, wens@csie.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v2] spi: sun6i: Add support for GPIO chip select lines
Date:   Sun, 10 May 2020 21:53:30 -0700
Message-Id: <20200511045330.690507-1-alistair@alistair23.me>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Set use_gpio_descriptors as true to support using generic GPIO
lines for the chip select.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
v2:
 - Use use_gpio_descriptors instead of spi_setup

 drivers/spi/spi-sun6i.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index ec7967be9e2f..ecea15534c42 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -470,6 +470,7 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 
 	master->max_speed_hz = 100 * 1000 * 1000;
 	master->min_speed_hz = 3 * 1000;
+	master->use_gpio_descriptors = true;
 	master->set_cs = sun6i_spi_set_cs;
 	master->transfer_one = sun6i_spi_transfer_one;
 	master->num_chipselect = 4;
-- 
2.26.2

