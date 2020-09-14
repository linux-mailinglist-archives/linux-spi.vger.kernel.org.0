Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A9E268987
	for <lists+linux-spi@lfdr.de>; Mon, 14 Sep 2020 12:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgINKk7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Sep 2020 06:40:59 -0400
Received: from mx2.securetransport.de ([188.68.39.254]:47616 "EHLO
        mx2.securetransport.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbgINKka (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 14 Sep 2020 06:40:30 -0400
X-Greylist: delayed 384 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Sep 2020 06:40:26 EDT
Received: from mail.dh-electronics.com (business-24-134-97-169.pool2.vodafone-ip.de [24.134.97.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.securetransport.de (Postfix) with ESMTPSA id 4025B5E879;
        Mon, 14 Sep 2020 12:33:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1600079597;
        bh=QqiALWQWqzk3v5Egngf7/oNah0zdhttVToTd3Q1YPvQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=tkjqpb1o8Of4A2fKxnLJoTJGfj3Sgr2FaVttqYfn6gwrqcAPlozgl5MpScJ/8J7vb
         +F7vh1Z/4Il6S6ICqH668xixkwxizgft4T0+gSpEITbuEROGQiU/OVmSrGh4CX1Msm
         9Twyh5t3llDHa3qPPhy+Doy49mMQ+1TU82yDjNz+uFmAzB/ZUPXs2zaaLjUYn0kIID
         BLbQDu3+iXvqwd+7hBQINr5Agq35uSPcJWt1VqkeB0r66OMlUsDVUomW1UhmeXDU4u
         7usFuA7bMc7yy7Imb/9Ne2T4JGI69wb1suEW9Un+ec3f5fbFkiwzDElqHKVJclP0R0
         O3NI5qCowHLqA==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (2001:470:76a7:2::30) by
 DHPWEX01.DH-ELECTRONICS.ORG (2001:470:76a7:2::30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.659.4;
 Mon, 14 Sep 2020 12:33:10 +0200
Received: from deb10-lzenz.dh-electronics.org (10.64.6.180) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.659.4
 via Frontend Transport; Mon, 14 Sep 2020 12:33:10 +0200
From:   Ludwig Zenz <lzenz@dh-electronics.com>
To:     <alain.volmat@st.com>
CC:     <alexandre.torgue@st.com>, <amelie.delaunay@st.com>,
        <broonie@kernel.org>, <fabrice.gasnier@st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <mcoquelin.stm32@gmail.com>, <marex@denx.de>
Subject: [PATCH v2 2/5] spi: stm32: fix fifo threshold level in case of short transfer
Date:   Mon, 14 Sep 2020 12:33:00 +0200
Message-ID: <20200914103300.5832-1-lzenz@dh-electronics.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1597043558-29668-3-git-send-email-alain.volmat@st.com>
References: <1597043558-29668-3-git-send-email-alain.volmat@st.com>
MIME-Version: 1.0
X-klartext: yes
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

> When transfer is shorter than half of the fifo, set the data packet size
> up to transfer size instead of up to half of the fifo.
> Check also that threshold is set at least to 1 data frame.

Through a git-bisect we have identified this patch as problematic. We have an application that uses a SPI protocol with telegrams of length 2 to 16 bytes. Due to this patch we have errors in the data transfer of the MOSI direction. We use SPI in PIO mode.

Please explain what this patch should improve or what exactly is changed in the behaviour.

best regards,
Ludwig Zenz
