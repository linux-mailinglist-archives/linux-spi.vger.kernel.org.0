Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA9E5B514D
	for <lists+linux-spi@lfdr.de>; Tue, 17 Sep 2019 17:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbfIQPVL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Sep 2019 11:21:11 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54318 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728387AbfIQPVL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 17 Sep 2019 11:21:11 -0400
Received: by mail-wm1-f66.google.com with SMTP id p7so3963894wmp.4
        for <linux-spi@vger.kernel.org>; Tue, 17 Sep 2019 08:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=OjulAGrUuGemM9gSZfSlGAauZMenX7YjWl3lxcSoow0=;
        b=NIs3zdhOCngBnuBHO1LbLej0XYA0fx3pJvBb5LAq9irsW8UeUktgNHXZMnDZxyaaOr
         2k+bvHUE/fHLZ7lf9Kul73T/QwVd+bmEflgxCK0SnHStHOhQnALmk8nuUmXyAzCWPul6
         tMU6PN1gvdxlyq/5hh21ijiyxq8ZglCxZeGrVjRnZhCGhY5VeaZ2hh7BtJOh1HISOtA8
         1CVnUwBkgaQ0rUpkQ3ZI8DTPHPTiJ4vJpGCsUBPhH185EKUvoa7BkmeUtt0yYJ9bTDs6
         u780dgRKf+UcHeceEUe9nq90hYS03wwSc0u8KF7NyWXCV7loB9k1CStMmQLhcJ1cU7zh
         34og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=OjulAGrUuGemM9gSZfSlGAauZMenX7YjWl3lxcSoow0=;
        b=AuskscCclMmMxggSrCmzVbonKBQw31fNpbuRM4tTQNfrEV/d8ENUb3g+JKZN6edsoc
         twHA3JlsgliOzNmfYGNiptDtzCenTjfSMkCfLTThmuFGU6UOYAwtm74VUOWO2xbPQcL2
         kXix8K2MqQz2aAnBu/LscdHkhiP5ixD4uWhMCGk35J9TX0pD0JPLZv25lgk6ERQqVkbx
         Xfk2qLiMHCVk4G0IQv3maXMhcFhQEDG9XbwdMEzyjKCaK46yXa2k+SxP2/vDPsqfyNkf
         KH//F3YHWJgGUgqvoyT4expWY4x/hlLYm0ce7XT8li8/sUZBtnrfzwJjh4yVUTosah8A
         GuBA==
X-Gm-Message-State: APjAAAUxcGM/XLCrpioQX6ZS2qQ9RPiQgdf0EKcMq3ZnMdkftn1eZUIh
        slDVh6nzR57SjMW6joxRkEiz7w==
X-Google-Smtp-Source: APXvYqwbUAYfuqjAyAa/Lkp2LToXiaq5d9pX178q4XtabOWrIVPxdsT1Xyr0gfOYq00MaiHPBKzAoA==
X-Received: by 2002:a1c:9988:: with SMTP id b130mr4310361wme.164.1568733668324;
        Tue, 17 Sep 2019 08:21:08 -0700 (PDT)
Received: from localhost ([195.200.173.126])
        by smtp.gmail.com with ESMTPSA id v8sm3712084wra.79.2019.09.17.08.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 08:21:07 -0700 (PDT)
Date:   Tue, 17 Sep 2019 08:21:06 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Aurabindo Jayamohanan <mail@aurabindo.in>
cc:     Baolin Wang <baolin.wang@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: sifive: check return value for
 platform_get_resource()
In-Reply-To: <alpine.DEB.2.21.9999.1909170709070.8198@viisi.sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1909170820470.21451@viisi.sifive.com>
References: <20190917085627.4562-1-mail@aurabindo.in> <CAMz4kuJczzjTPSohQ=kbZ0Pr7U_9-hzXk-jPgKk79PENOM1-dA@mail.gmail.com> <alpine.DEB.2.21.9999.1909170514130.11980@viisi.sifive.com> <ij_UksEXUomr_L7KQam02lHBryAppgwKDjG90VbVcRRUeXlKU8TAiBWc3aU8vt20Wvlwt_6NDgz5fuMSwwP1mm-1eP6GYWoR1Kbr0y0ElRk=@aurabindo.in>
 <alpine.DEB.2.21.9999.1909170709070.8198@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


I just recalled that YueHaibing already posted a patch to do this:

https://lore.kernel.org/linux-riscv/alpine.DEB.2.21.9999.1909041520130.13502@viisi.sifive.com/


- Paul
