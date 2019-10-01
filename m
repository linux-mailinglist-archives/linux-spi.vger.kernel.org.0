Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6C38C332C
	for <lists+linux-spi@lfdr.de>; Tue,  1 Oct 2019 13:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733193AbfJALnH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Oct 2019 07:43:07 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43857 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732551AbfJALnH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Oct 2019 07:43:07 -0400
Received: by mail-ot1-f66.google.com with SMTP id o44so11219832ota.10;
        Tue, 01 Oct 2019 04:43:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qBJxEX/eYnXyleU23su6cmwpDx2vW/AsucVLt4T1oY4=;
        b=SrsvjXJAyeqsNBsGElZzT0KGkSpYuK7sgq24G1As8ftzrIo5rti/JbqiykhlyXFgf5
         JiFMXxcYB46QQFKQLv51qlcLKR76vvmZMb850QW7WDRNCv1NaxCNfhN2NIpuCsEwtQRA
         JYZ11SzpZo2SicOb9h7OS9vCAlbNGmdFze4CGAGhwV0j4O0j/rpfoiv/+o2MnCtivnfR
         wOPs4SM40cggEScQYnNGPwtxAehpP1Tv1FczsjQINj/xGtGPVshdS9ySoOiEKKNcWYuu
         itY6TkXQOduNJ0j/lIG1r7bOP4MKbPQ72ef0+U50YJ1YHj7gVznkrbm1d37kUAjurMrI
         8TXQ==
X-Gm-Message-State: APjAAAXQ56GkXLcwBCBnG/O/fGmPNIHRqrJcbGnjZ9X5LtmjBGifsg+b
        6oHsot2LswliCmgOb6DWkFS3Xu+4Wg==
X-Google-Smtp-Source: APXvYqzG8a5/BqVOShp3MMjA8cBOESjkC8SFtqntj1uGWf40TDhUIGK4H9QgRbGE2/PDdzHrHHNLYw==
X-Received: by 2002:a9d:3b26:: with SMTP id z35mr17205216otb.182.1569930186825;
        Tue, 01 Oct 2019 04:43:06 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q199sm5116011oic.16.2019.10.01.04.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 04:43:06 -0700 (PDT)
Date:   Tue, 1 Oct 2019 06:43:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Gareth Williams <gareth.williams.jx@renesas.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gareth Williams <gareth.williams.jx@renesas.com>
Subject: Re: [PATCH v2 1/4] dt: spi: Add Renesas RZ/N1 binding documentation
Message-ID: <20191001114305.GA27944@bogus>
References: <1568793876-9009-1-git-send-email-gareth.williams.jx@renesas.com>
 <1568793876-9009-2-git-send-email-gareth.williams.jx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568793876-9009-2-git-send-email-gareth.williams.jx@renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 18 Sep 2019 09:04:33 +0100, Gareth Williams wrote:
> From: Phil Edworthy <phil.edworthy@renesas.com>
> 
> The Renesas RZ/N1 SPI Controller is based on the Synopsys DW SSI, but has
> additional registers for software CS control and DMA. This patch does not
> address the changes required for DMA support, it simply adds the compatible
> string. The CS functionality is not very useful and also not needed as
> Linux can use gpios for the CS signals.
> 
> Add a compatible string to handle any unforeseen issues that may arise, and
> pave the way for DMA support.
> 
> Signed-off-by: Gareth Williams <gareth.williams.jx@renesas.com>
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
> Note: All the other manufacturers detail their compatible strings in
> snps,dw-apb-ssi.txt. I think it makes sense for rzn1 to be in it's own file
> due to the changes made to the peripheral for DMA support.
> 
> v2:
>  - No changes.
> ---
>  Documentation/devicetree/bindings/spi/renesas,rzn1-spi.txt | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/renesas,rzn1-spi.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
