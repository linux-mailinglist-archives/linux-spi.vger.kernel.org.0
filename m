Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357031F7B96
	for <lists+linux-spi@lfdr.de>; Fri, 12 Jun 2020 18:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgFLQZ3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 12 Jun 2020 12:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgFLQZ2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 12 Jun 2020 12:25:28 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4E3C03E96F
        for <linux-spi@vger.kernel.org>; Fri, 12 Jun 2020 09:25:27 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id mb16so10682993ejb.4
        for <linux-spi@vger.kernel.org>; Fri, 12 Jun 2020 09:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastree3d-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=vefuP+clNxA7X4UQbZkJAxXroYLrRWICptMl/46Rru8=;
        b=oWR1XjaefoEaxKMT3NdZ0KIZ8viQ0VcSrcO/NgpBiNVSDtlhsFA6wRJhnwlZNzsbdm
         RlmetLDQ56bNFKbG9SSwPZVTAETmmEWnKHiYIjwkt/dE113M5CjV2yyGx0Gt8JF9tVp3
         FsHboA4IJn+waLDn6GAjIL/d5XW2PTbJ76JhZiPCnagRMakpgZbrcB3MZmYJIzj/bWv4
         ShlN3m+gVdDMEajS04nyJV9AgrGmilsr1jL2QCX8Z0XCqZjgb5geUmOYYlRd+f7K3yma
         Npbi17jTukBMyIjqwd/wr44nXlnyqggzKfHmR5fMe6rc0wcGQKRgn5g/8KQnwJ0aKKBB
         fjFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=vefuP+clNxA7X4UQbZkJAxXroYLrRWICptMl/46Rru8=;
        b=iYN8Ra28yk5wScv2Qb+Lp+QsWmzpsw3jfHjdyCYCl8MJzatieCNcudxwlflL9/6fyg
         1aYws759RaH2M6+AzFmz42g8be/Shdw/1fDYnReRZbDquKJTqRViO1+E845KEAjGlhqK
         hAXVkUKVqgPGhhYQckMqNYCjOPIO/aOVeZgGi+tWj2pQD8Z8T6ekBS7M5mArTVCYcWKQ
         b2YmxlV6tfLE+S73pFZFtBYQzSnWgpqF9JchUbczEP9zj8uc2csuzHyWyhV7i01jyLAv
         baiNzB8HrdRzY8+BIDmxht/8WkUVQiYLFGJyfz3w63+ZRIKqyWxb2vAoyR2Fq4L1rFqL
         EUcA==
X-Gm-Message-State: AOAM530UMt43Ug2a9CUqLF3vivJZz4M1hoGZ9luYU3yKdJ2Gt7ZaDXAH
        ygBoyQbQHn2bNxYDpD+8ttwhQilCow==
X-Google-Smtp-Source: ABdhPJxIFnPUxlG86vD78act6/x3n22X8ybLf722T7msuswPWkLlythvY4ZjAx/9R+lYXxBw9OeU0w==
X-Received: by 2002:a17:906:7c58:: with SMTP id g24mr14734120ejp.205.1591979125911;
        Fri, 12 Jun 2020 09:25:25 -0700 (PDT)
Received: from [192.168.33.195] (fastree1.epfl.ch. [192.26.37.52])
        by smtp.gmail.com with ESMTPSA id z26sm3405667edm.1.2020.06.12.09.25.25
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2020 09:25:25 -0700 (PDT)
From:   Adrian Fiergolski <adrian.fiergolski@fastree3d.com>
X-Google-Original-From: Adrian Fiergolski <Adrian.Fiergolski@fastree3d.com>
To:     linux-spi@vger.kernel.org
Subject: [cadence-spi] daisy chain
Message-ID: <7cddc1a3-f3a8-37dd-487a-cd2274b7941c@fastree3d.com>
Date:   Fri, 12 Jun 2020 18:25:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

I have a daisy chain of three ltc2634 slaves (iio/dac/ltc2632.c)
connected to a single chip select of the cadence-spi master. I have the
impression such a configuration is supported by none of those two
drivers. I could try to extend both, however, I haven't found any other
SPI driver, where I could find implementation inspiration. Is it
supported by kernel?

The documentation mentions only about the common 'daisy-chained-devices'
property (devicetree/bindings/common-properties.txt). However, in order
to try to implement it in the master driver, IMHO, the spi subsystem
would need to have a call 'no-operation' to other nodes on the
daisy-chain, which are not addressed by the given SPI access. Is there
any recommended approach to address this case?

Regards,

Adrian

