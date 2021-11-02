Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD185443878
	for <lists+linux-spi@lfdr.de>; Tue,  2 Nov 2021 23:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhKBWdS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Nov 2021 18:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbhKBWdR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 2 Nov 2021 18:33:17 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A9FC061714
        for <linux-spi@vger.kernel.org>; Tue,  2 Nov 2021 15:30:42 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id y3so1877327ybf.2
        for <linux-spi@vger.kernel.org>; Tue, 02 Nov 2021 15:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=ELWqzWjjuxL2xN+87TQmQIS76Vc/rNBmh2sCxCiVIrc=;
        b=JNGitCbFJFC8/lvGkLLRwrp5T6sqB3oGhAwKjbZ8RWUdc0AA282H39Sty7t/VQBRR9
         6xnUoM7AVI0cWLtjkc+GJekLE2mrr3GBQqudapN1pCuaY+bVmL/EVT0z4I1xTbyqfDLZ
         vf80mHjovfvgLwkEk6bEFhot/YKaK+EEKsfn8wihvUB7BwkMOtUurIZ+lFkjHY0pW02y
         6Dthtq2sCMBftySW7Z4MjeEpqu+BgpWQ+V5YxW9koqJ6a5UhLgyNtlv4oADvdCf02Dwr
         intxYnU5UqsAGMVz8IxXalxFmKTuV66t7Qr+WtRfCfVm1tLWLHYTA58Net/qCY03aTMF
         v7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ELWqzWjjuxL2xN+87TQmQIS76Vc/rNBmh2sCxCiVIrc=;
        b=oiC9UVUvSPtFaBgq0+UXBJMKCdIIFwE/ARHyyW1c7DB+JJiujdS/eWE+vPBLtAchAd
         9zZ395S0E1oiBm7hHkkHte/PrYqgfi68Kx2t4DlKjQeXAh2M7EALpoJebOpJmjWmCQqS
         P4iezBvQHgV4l4UBecv4+ZJuicqtXiUPREqFLdAtTcJTC1NC3CZ9BobHVgTgIYeRCWCx
         MuQWd2+EQ44WnJc+mG/dvc9yMCG1jDQH04DWvwQVQ8zGPahFh8th/RMEa/QvZHP4ZXCR
         gyqRRbYeOAxn0RBPACPYEpFHqzT/4VFyrMDVXkDwaFQtsTyXeCqQOnyfKERqX0CP+D2e
         I79Q==
X-Gm-Message-State: AOAM531l3C7jHtjAAArkOKip+EBTHpB2OUo5fwicg3JtVPO0jpIFda4B
        zrW4zAbCx7bQu1W77p+sLCnk3InS4UHTA1jdfTkuuhBqpLw=
X-Google-Smtp-Source: ABdhPJzpWw/t9w2LpQvu4ff8G/BgHFE+bMhp23fyldBCIHqQaHSpiH6nKEKo7MGbix00Zq9QrB33R41qfXs5qjS2zWU=
X-Received: by 2002:a25:aa43:: with SMTP id s61mr31226781ybi.186.1635892240897;
 Tue, 02 Nov 2021 15:30:40 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Bender <codehero@gmail.com>
Date:   Tue, 2 Nov 2021 18:30:30 -0400
Message-ID: <CAETHaKpiZEWHUrKtNw+W3XHAPUA4h=OC=RL4Jbcs94o1MgDj6w@mail.gmail.com>
Subject: spi-ar934x: Using GPIO CS issue
To:     linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Under the mach-* era of configuring boards, I was able to use a second
SPI NOR flash with a GPIO chip select, as in:

static struct spi_board_info spi_info[] = {
       { ... },
       {
               .bus_num        = 0,
               .chip_select    = 1,
               .max_speed_hz   = 25000000,
               .modalias       = "m25p80",
       },
};

static int cs_gpios[2] = {
       -ENOENT,
       11,
};

static struct ath79_spi_platform_data mtriq_spi_data __initdata = {
       .bus_num = 0
       ,.num_chipselect = 2
       ,.cs_gpios = cs_gpios
};

static void __init board_setup(){
 ath79_register_spi(&spi_data, spi_info, 2);
}


However, under the new dts regime, I try to use a CS gpio but cannot
communicate successfully to the chip:

&spi {
    status = "okay";
    cs-gpios = <0>,<&gpio 11 GPIO_ACTIVE_LOW>;

    flash@1 {
    compatible = "jedec,spi-nor";
    spi-max-frequency = <25000000>;
    reg = <1>;
  };
};

Am I missing something here?
