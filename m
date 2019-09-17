Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA508B4A30
	for <lists+linux-spi@lfdr.de>; Tue, 17 Sep 2019 11:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfIQJSQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Sep 2019 05:18:16 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43344 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbfIQJSQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 17 Sep 2019 05:18:16 -0400
Received: by mail-wr1-f66.google.com with SMTP id q17so2262827wrx.10
        for <linux-spi@vger.kernel.org>; Tue, 17 Sep 2019 02:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ZmyRTH11FKZjg3p5bM7cG4+5udISP5256aWYiASckV4=;
        b=dHJuIjqRrMgYB6fmsR6dYurmuJBGEplDO2KM8mJBxvGK3M53S8DAFRSK5dQwECdgo0
         Gg2XAY0BNCAkaT/SxqegMe6rlZNrz9i6rFpfy2td6EfNmHUON7rzQkU/XovsjYJ90y+t
         K33DN9idOuOz2XnClLuxfxO38v7z8Im6sfNbjjKsVwPAwR1fnS5LVeIko7SxjXHIq7To
         4RWuwxLjux3xOfSZedVplKgwccufxiplMB1/w6XOwgDZtXsKOxNtYDoOn4L7uAF/gH38
         uXjC4ywXmgWtO77ZW45qC+KW/pWaepiGGlKxyoPYKN8gmJFbmPUmaBNo/nuwn2WUNtKr
         Ccug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ZmyRTH11FKZjg3p5bM7cG4+5udISP5256aWYiASckV4=;
        b=Xkhb6X7X5MnhKqmCJ9KQXDFGwZv7hvLDY3k7WLy3w2V/IxqEz5Oqwcbcbl9ttL7eUZ
         eCU0dCVVHX48YPP2wfDdW4+a3/ofxl7VbmNOL+YOV6L1+d14lovxsE8iMmvB2U48r4oa
         XJO65yAqdKyGU1XReZpCs1Hyt6zaPF7wtz6z9x/LGs0K0sbpbFAFnnXRPgDBPuaQttZR
         hhyOSlfhBUbPHaX2VLtDWJbCcYnh3xkFYGnjkX5ReQL24sH1ambI3ahkv30O9OvvrDS+
         JMEzVMARyBRItvqetH09ZsLF5OXtSqvlodh9k8bl7TeU7g2QL+pVuyichlp2K4v0Ft7O
         IWNg==
X-Gm-Message-State: APjAAAU9ReZXW0551+FOULZQ22VYP/ykW92FHWXX0Cqw+5NOroi/4ik6
        d5SH1CUD0xvEocS4KA2iCCTT5w==
X-Google-Smtp-Source: APXvYqzMcsMkF+IzOhVUpVJstLoCK/jTQlsQSur1FiOv4mcOYSPoHSHQehqpCbl+eHk03Y8y2kTFOA==
X-Received: by 2002:a5d:5111:: with SMTP id s17mr2177174wrt.59.1568711894210;
        Tue, 17 Sep 2019 02:18:14 -0700 (PDT)
Received: from localhost ([195.200.173.126])
        by smtp.gmail.com with ESMTPSA id 26sm1849272wmf.20.2019.09.17.02.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 02:18:13 -0700 (PDT)
Date:   Tue, 17 Sep 2019 02:18:12 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Aurabindo Jayamohanan <mail@aurabindo.in>
cc:     broonie@kernel.org, palmer@sifive.com, linux-spi@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: sifive: check return value for
 platform_get_resource()
In-Reply-To: <20190917085627.4562-1-mail@aurabindo.in>
Message-ID: <alpine.DEB.2.21.9999.1909170216200.4260@viisi.sifive.com>
References: <20190917085627.4562-1-mail@aurabindo.in>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 17 Sep 2019, Aurabindo Jayamohanan wrote:

> platform_get_resource() may return NULL. If it is so, return -ENXIO
> 
> Signed-off-by: Aurabindo Jayamohanan <mail@aurabindo.in>

Reviewed-by: Paul Walmsley <paul.walmsley@sifive.com>


- Paul
