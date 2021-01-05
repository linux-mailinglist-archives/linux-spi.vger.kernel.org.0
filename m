Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEFDB2EB10F
	for <lists+linux-spi@lfdr.de>; Tue,  5 Jan 2021 18:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730567AbhAERIO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 5 Jan 2021 12:08:14 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:33423 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730430AbhAERIN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 5 Jan 2021 12:08:13 -0500
Received: by mail-wm1-f46.google.com with SMTP id n16so1796008wmc.0;
        Tue, 05 Jan 2021 09:07:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8PYxaFWJILkA0uxuXAUf3F8/Qw1AAhsYzrjrCjqXI7k=;
        b=qGEELhKWQeJW+KUFF5yZntH8F8B9EbAFXoAfONfAF7Sqjck9HvVy+zniRZDSGEiy/u
         SnvFM2chszpYmUhdPoitqjTb3Ag7i3xe/OVpqt0Y4cTDL9RVfdcDXswG1P4FEjZhDuJl
         uSNn+kiAIa7zyblT5w5K868qB9oCS1fllCq/YDd9nQZm/EZH3/EIX+AR49cREHWQ53i1
         b7tNNVU9iSBciLf59R7MI78Ial1DmFcrQecQTyTD2+rtxGhiczk3pBGgDyqWan9d1wVK
         yuMh4OBBvW1G7cBd6+Xm0webuYlWOllrG6thR76ZLQ+c5ytQ8hN/F9bdddauh12zN0x8
         sEyg==
X-Gm-Message-State: AOAM532pOYORbJE2IEMCGG0WeejxnGPbHDsO6W2BMhSrb4BUOgeKlr2W
        2lKc5YmO6omHgOa7VssCjTM=
X-Google-Smtp-Source: ABdhPJxole5Jba/g/S9ffjnINCy2WoPPG8JGvO/6WzDtgMTesiKUa/VhOrUaZ26zbSIRvODyIXpagg==
X-Received: by 2002:a7b:c212:: with SMTP id x18mr86991wmi.113.1609866451239;
        Tue, 05 Jan 2021 09:07:31 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id n11sm587517wra.9.2021.01.05.09.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 09:07:30 -0800 (PST)
Date:   Tue, 5 Jan 2021 18:07:28 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-renesas-soc@vger.kernel.org, aford@beaconembedded.com,
        biju.das.jz@bp.renesas.com, Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH V2 2/4] memory: renesas rpc-if: Update Add RZ/G2 to
 Kconfig description
Message-ID: <20210105170728.GB26301@kozik-lap>
References: <20210102115412.3402059-1-aford173@gmail.com>
 <20210102115412.3402059-2-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210102115412.3402059-2-aford173@gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, Jan 02, 2021 at 05:54:10AM -0600, Adam Ford wrote:
> The Renesas RPC-IF is present on the RZ/G2 Series.  Add that to
> the description.
> 
> Suggested-by: Biju Das <biju.das.jz@bp.renesas.com>
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
>  drivers/memory/Kconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Thanks, applied with commit title change (renesas-rpc-if:) and fix
pointed out by Geert.

Best regards,
Krzysztof

