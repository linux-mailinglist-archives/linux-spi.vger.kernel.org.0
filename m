Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B907D1D8932
	for <lists+linux-spi@lfdr.de>; Mon, 18 May 2020 22:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgERUby (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 18 May 2020 16:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgERUby (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 18 May 2020 16:31:54 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC9DC061A0C
        for <linux-spi@vger.kernel.org>; Mon, 18 May 2020 13:31:54 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id z22so9286728lfd.0
        for <linux-spi@vger.kernel.org>; Mon, 18 May 2020 13:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:organization:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=BmSBD7h3njitpLi5QsmTDnHJWiGkucDb02pMa3UrBRI=;
        b=S/V2meIHX6iNtfRVQH6gN/h2Lyp5uwDpI0DvK0EGXJdBE8jiAkFT97P5mkXdh2m3qW
         ubkAh6O+D9ZIP0TmMu3wEF23N+L0d1FbplsFxsXfmJkWqBx/FecsnSOhqcbJSZalCmSX
         ab2E8KVO0NHXnv45BislI93lru50zeVPdIXNKU8o7U2BmVysz3A37I1k07XWaEjHG9tt
         QCNMsjiHo9N9IDnZAKrkwUP4eE2k4MJ0+/P7m2/02hKLGgbf1HVZsvZVfuDJpKcGOkeU
         V3Sm5fQgFuy8ce7soIHMMb1eQvOblNhAIkIaWlcnoPIUqVXoXZ0WnYTvkon9naCb3Zky
         fmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:organization:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=BmSBD7h3njitpLi5QsmTDnHJWiGkucDb02pMa3UrBRI=;
        b=Tdpb0is+9T4gmMB6S/KDsMKi1o3I4oYcNlKe+H+MdqFo0a+dIPl3jjzWoNGzAIhTLB
         C38fmkZ+nPUx1bNxt5OzMaO9ZLZP6oDtc4631tkHypHlMcDzNvNDqc47czMGYPoOgMQm
         fzzPu6dgisSvnvshiyYV+lwX8YDImMWlPjTr5d7DA77xsuntTePLf2NLprsaMaBVHKM6
         YYVK1sP4jHN33BqQKOXjZu3naaXys1ECvOxacpNgwKdQa6uOSKA5FT3aM08wws7bh61y
         WA8mLL3ZZHwooS7c2py3eS0SWuP5Sq8Vh/Lj9CJBZu4mP/cq0saxDfZo1tGZPClud3Gl
         6urQ==
X-Gm-Message-State: AOAM533AQr63+MqCQs84ZWrBC+6YadyqS8QmpHF7fCpyCBWqACVukcxI
        98s1uljvoFr9QBvgVQinEkzAdRoYaxk=
X-Google-Smtp-Source: ABdhPJwbeRgWCUksn3Rp9PyliuSUUrgdtDgGrHAVgDph+uCNv8e0tKIc/Q6nrbUUHFC0gCY5cMqmTg==
X-Received: by 2002:a19:990:: with SMTP id 138mr7817351lfj.135.1589833912488;
        Mon, 18 May 2020 13:31:52 -0700 (PDT)
Received: from wasted.cogentembedded.com ([2a00:1fa0:4650:c10:49f1:792f:a411:29a7])
        by smtp.gmail.com with ESMTPSA id z17sm7136988ljc.81.2020.05.18.13.31.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2020 13:31:51 -0700 (PDT)
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH v3 0/2] Add Renesas RPC-IF support
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Yang <masonccyang@mxic.com.tw>,
        linux-spi@vger.kernel.org, Chris Brandt <chris.brandt@renesas.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
Organization: Cogent Embedded
Message-ID: <26faf5e8-26eb-cceb-a500-f0fd64609737@cogentembedded.com>
Date:   Mon, 18 May 2020 23:31:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello!

Here's a set of 2 patches against Linus' repo. Renesas Reduced Pin Count
Interface (RPC-IF) allows a SPI flash or HyperFlash connected to the SoC
to be accessed via the external address space read mode or the manual mode.
The memory controller driver for RPC-IF registers either SPI or HyperFLash
subdevice, depending on the contents of the device tree subnode; it also
provides the abstract "back end" API that can be used by the "front end"
SPI/MTD drivers to talk to the real hardware...

Based on the original patch by Mason Yang <masonccyang@mxic.com.tw>.

[1/2] dt-bindings: memory: document Renesas RPC-IF bindings
[2/2] memory: add Renesas RPC-IF driver

MBR, Sergei
