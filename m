Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7950745CD48
	for <lists+linux-spi@lfdr.de>; Wed, 24 Nov 2021 20:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351267AbhKXThP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 24 Nov 2021 14:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244708AbhKXThP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 24 Nov 2021 14:37:15 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155FFC061746;
        Wed, 24 Nov 2021 11:34:05 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id np6-20020a17090b4c4600b001a90b011e06so3635766pjb.5;
        Wed, 24 Nov 2021 11:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=1oaLKXzhu1Hk6tm+NRAjuoiXVD/SKX/uiKglLJfxkSM=;
        b=nk+ulMg6JZK9iDUvFGMWtU0yrvEkCqlSuPjMO3dQzZkj6BNbYNuORqpLNKb6zBApSn
         a9P83Iyruz32md/qsHiT2vzI3ZsClLiLWwsZ73j1E95BnebtkaJ5+EgejkPzkkyu8yp4
         dfmCMRFdlzK/9EMppC/2nO3X28RPVCxw71Cdbrc9vpyY1mZrx+JuQxBFkUFEN6JMpo9p
         npKW8raFeyc5Q6K2tbHcZ/18pCaRC4XEXFrToALWdXv9U0sFUZPdp2wHe4DdUjipxG9u
         7jiNgD6vxx2xa18eQuBJPih+verGw19XBappEk+NTbsWpCJXVcrEQhghY6Ie92PQEpPS
         83GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1oaLKXzhu1Hk6tm+NRAjuoiXVD/SKX/uiKglLJfxkSM=;
        b=w2w9Vd7yjdn26hvzM67A1R7b+jtbjeCCpxLViz0mcOXT+U8qKGTKJ+HhJV388Xh/4i
         KfgxNgEH1Mc66VBOdIRjCAD/m3arXEgoRXWPXtdFC7f+DCrq1F/+pgw/IEO+rrNURMqB
         o7w7BmLod6jedaIYza2ikLfASrv1aNiCvWpzrXtQc3fNLXcqFAaJgaIzTjZI6WujH9VK
         5flyky6ST0X47LN5ltu+kzYB7Yxz0ag+3Mmk8fX+nV1hoIR5/hocAIC0RRvOWtujh5z+
         iBM6/WVxUJdVql5woSuZrUqk0HpgHdvr/BvW+F+w3llNvX0ZT+8+jkRm4w+KmuhsI7HA
         bsLw==
X-Gm-Message-State: AOAM533WprBU6+k7n+yHH7hv615itPuJxcSAeMhmHYstkJaI20W8l6z0
        ldBlHB++JmtO5UUin6z22ps=
X-Google-Smtp-Source: ABdhPJzO8wW+vMtJUl8NSROkI8z7QNroxMHH9Dn7cC8uEMiZLeiwveEwK7BZFhfECLfHtyTXW/rOAg==
X-Received: by 2002:a17:90a:8815:: with SMTP id s21mr12418750pjn.82.1637782444675;
        Wed, 24 Nov 2021 11:34:04 -0800 (PST)
Received: from mail.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id v38sm349510pgl.38.2021.11.24.11.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 11:34:04 -0800 (PST)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        yendapally.reddy@broadcom.com, Kamal Dasu <kdasu.kdev@gmail.com>
Subject: [PATCH 0/2] spi transfer paramater changes and baud rate calculation
Date:   Wed, 24 Nov 2021 14:33:51 -0500
Message-Id: <20211124193353.32311-1-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The changes picks either the 27Mhz or 108MhZ system clock for spi transfers
based user requested transfer speed. Also we set the master controller transfer
parameter only if they change.

Kamal Dasu (2):
  spi: bcm-qspi: choose sysclk setting based on requested speed
  spi: bcm-qspi: set transfer parameter only if they change

 drivers/spi/spi-bcm-qspi.c | 44 ++++++++++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 6 deletions(-)

-- 
2.17.1

