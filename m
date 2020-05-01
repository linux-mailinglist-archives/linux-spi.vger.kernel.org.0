Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 820201C106B
	for <lists+linux-spi@lfdr.de>; Fri,  1 May 2020 11:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbgEAJgv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 1 May 2020 05:36:51 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38230 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728325AbgEAJgv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 1 May 2020 05:36:51 -0400
Received: by mail-oi1-f194.google.com with SMTP id r66so2258850oie.5;
        Fri, 01 May 2020 02:36:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QNmi3J1oG0BHibSA3NPDSx73IEYskXDbHrY+NDqOrXs=;
        b=eoVf6yLCx9y8Lf+B7eEm42qZML0z239NzMFbgb77i+m6CuQR2CmmBdWCi6ZSkc+e+d
         Mt75qrEXlL7l0N2ZKgAemyMgZCws/abm1KU1v3zmYce1aslWW3ou8eNkrevlSfj5yjyl
         6avDxgCpQhkdyhvjz4Z0+QkZAb8i89pCsLo/60PZVMEig4gp/Xgg8J4fbfNHTjM/Lr/d
         mYdgCt0FFgyDx87YjEujXCPIowpXNRfiMt9F2ahO4sa+vQVD1igdBpnlNsQAabmcTGMb
         cieI1y7tb6dil1bhBKBx7Jrb6fZnoBVUKR155c2frJTBJrS2Mz7ZGlQS3prjQZHBXxgA
         4U7g==
X-Gm-Message-State: AGi0PuaAnPacnDTtEBnCGZPMrTn/j0nj3aGJyjaCtPdnXdEuCAei+pbx
        wJGcP9q6ojXlK+l51TYhA7/oK3jiNeDvnHFM/ms=
X-Google-Smtp-Source: APiQypIxuQX0hYIBKT5wCQqTw8uzBxU4StAmBh2v/MqxavCTiCkalP8HD2pDbGBi6s2kyN5W4y2cYwdW/AXBft42Weo=
X-Received: by 2002:aca:d50f:: with SMTP id m15mr2464791oig.54.1588325810218;
 Fri, 01 May 2020 02:36:50 -0700 (PDT)
MIME-Version: 1.0
References: <812e6e58-d13f-3f44-5f55-22266b690c57@cogentembedded.com>
In-Reply-To: <812e6e58-d13f-3f44-5f55-22266b690c57@cogentembedded.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 1 May 2020 11:36:38 +0200
Message-ID: <CAMuHMdU5zcmBuWKVxEhF1G1uYHS0iVKUtuWURX68meppMKWHeA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add Renesas RPC-IF support
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Chris Brandt <chris.brandt@renesas.com>,
        Mason Yang <masonccyang@mxic.com.tw>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-spi <linux-spi@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

CC marex, linux-renesas-soc

On Thu, Apr 30, 2020 at 10:45 PM Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Here's a set of 2 patches against Linus' repo. Renesas Reduced Pin Count
> Interface (RPC-IF) allows a SPI flash or HyperFlash connected to the SoC
> to be accessed via the external address space read mode or the manual mode.
> The memory controller driver for RPC-IF registers either SPI or HyperFLash
> subdevice, depending on the contents of the device tree subnode; it also
> provides the abstract "back end" API that can be used by the "front end"
> SPI/MTD drivers to talk to the real hardware...
>
> Based on the original patch by Mason Yang <masonccyang@mxic.com.tw>.
>
> [1/2] dt-bindings: memory: document Renesas RPC-IF bindings
> [2/2] memory: add Renesas RPC-IF driver
>
> MBR, Sergei
>
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
