Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5B50427260
	for <lists+linux-spi@lfdr.de>; Fri,  8 Oct 2021 22:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242193AbhJHUiH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 Oct 2021 16:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbhJHUiE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 8 Oct 2021 16:38:04 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BD3C061570;
        Fri,  8 Oct 2021 13:36:09 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id r201so4186561pgr.4;
        Fri, 08 Oct 2021 13:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=eKNj33ROPAiiz6HEb1YbJ/psL1Dxl8l7bxVvQctQgPA=;
        b=limhVz1+VVawgNLASfhlTm+35N+voLYk3l8qQns9SRaJ0Uvo2n2Qy2q4zezA19GPwY
         DIr3lzFHajXy6tTHHDxrEkRdplYYciKTR7KvlIvKy4ALx43qYxnbHVpjc/8NzH71dUwY
         DuemGhHyVvmVaLw/c7hleZ2X2x4cQYStNlPWi6+rrMnwAabN8bzYiNpyKQ9JdqQWGSdC
         yM3hE/z4iqBaM/IcVfZIsAV7TuaknieOipv53RILqIrrTSJl0EaUyNINXWXj+FVtQdUd
         y5rcSquxKEA6HHUZm9W1fgp6+1i0jAbdur2R0YOimgwz2VNRa64coNLvFzJbDNwDXYzl
         HSdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eKNj33ROPAiiz6HEb1YbJ/psL1Dxl8l7bxVvQctQgPA=;
        b=pckmTDaJtH58zpBiQ4W5ZRMewcdttoDEUjXA8OfHP3vTtt8qgL/tclVBHOXgP50JHs
         ml2CP7ZGb2Y4zeEW+sSO5PyyXelFC0OfzPsP1gx+NO9W6SBEhtkTWMlYeo1POWPvVxss
         I9HwcrN3s/IguwkX/ohl00Do4Q+nKxMf9hb9JPBqT2Hxz+OHgI0hE33fwbJ9gKFzUuGr
         F3L5/AmhEoKyTVUxR8HZtMf/jpakZjxnj6HmQZOSfsh0PDKEXpIbQR5Fz1BXqgCoeUfC
         yGAbRHEdxlw+Na48liDoJjVyqgRwRejSZAoIx+yI5nc3PQWCtwOLCE5LhsnKyaWK6eIP
         z6jg==
X-Gm-Message-State: AOAM533tSE3LyoPS8NR3sdu/+2GPHHu9g+aNtCzaRRdN73doSjg0OptU
        DI5JIBub4RdqaQr7uQh/QUE=
X-Google-Smtp-Source: ABdhPJw0/Y+yqIdnZvvAAvO/mtivKW7bElITB5mgrMqwNTzNeU8/gtcJ457vpkHJH8+B1sg5pV9XQg==
X-Received: by 2002:a62:6541:0:b0:44c:2988:7d9d with SMTP id z62-20020a626541000000b0044c29887d9dmr12070013pfb.50.1633725368615;
        Fri, 08 Oct 2021 13:36:08 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id q6sm117615pjd.26.2021.10.08.13.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 13:36:08 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        yendapally.reddy@broadcom.com, Kamal Dasu <kdasu.kdev@gmail.com>
Subject: [PATCH 0/3] spi-bcm-qspi spcr3 enahancements
Date:   Fri,  8 Oct 2021 16:36:00 -0400
Message-Id: <20211008203603.40915-1-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This change set feature enahancements for spcr3 transfer modes as well as
adds support for half-duplex 3-wire mode transfer. 

Kamal Dasu (3):
  spi: bcm-qspi: Add mspi spcr3 32/64-bits xfer mode
  spi: bcm-qspi: clear MSPI spifie interrupt during probe
  spi: bcm-qspi: add support for 3-wire mode for half duplex transfer

 drivers/spi/spi-bcm-qspi.c | 262 +++++++++++++++++++++++++++++--------
 1 file changed, 208 insertions(+), 54 deletions(-)

-- 
2.17.1

