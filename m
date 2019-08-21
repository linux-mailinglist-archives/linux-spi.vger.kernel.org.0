Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B72E9830B
	for <lists+linux-spi@lfdr.de>; Wed, 21 Aug 2019 20:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfHUSeO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 21 Aug 2019 14:34:14 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44311 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbfHUSeN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 21 Aug 2019 14:34:13 -0400
Received: by mail-oi1-f193.google.com with SMTP id k22so2347599oiw.11;
        Wed, 21 Aug 2019 11:34:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gi2BZPRlk0uA2JzVWQCJU+s6t1qhy8lKwkC+6999UAg=;
        b=IsOv291JMyHDIF/Ml4tt/YNVWOBn6d86CqQUZZmPH7RbzjseJ34W7FXtuzs+Wm0YOD
         SeekYwZKyUzfpoTG0HiWdQNLIyO8fM4Yg18KNGN1fNqutNqiLqGKpZFHyOMm3TyniTEL
         zvo6MykN311SB27l8taZCELBSXLgdlZZ1b8BZctSReSYRbcuAAPvIlzgZ4OT31paSxuF
         wCZA4SSIc8H89vu1SXYDA7T1gtvTcM6rnfJOPqulGiF0qDmBpXZ73KbQrM5S3ea5yf0i
         jOJXmoe5+vqWVOz0GphNufXctte+0kPAcSNuAcUq1qgJJTBI23WCck/LXXXtXzVmNW3a
         hDpw==
X-Gm-Message-State: APjAAAXJn7o01Fm9E6F3E+GynBhVdKg58+7tuOXLAy19frPe8hrnHR5V
        AoD/CCqrQUSKF3PkOlS47Q==
X-Google-Smtp-Source: APXvYqx3DnJdbJxJ1b1jmrQ8KW6WnZtAF9psvXnB9Q4r34aJ0FaUBKFmSuJmxrnz4HGTVJO0BtdgUQ==
X-Received: by 2002:aca:4f48:: with SMTP id d69mr1082979oib.74.1566412453047;
        Wed, 21 Aug 2019 11:34:13 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v5sm8044571otk.64.2019.08.21.11.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 11:34:12 -0700 (PDT)
Date:   Wed, 21 Aug 2019 13:34:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chuanhua Han <chuanhua.han@nxp.com>
Cc:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, leoyang.li@nxp.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Chuanhua Han <chuanhua.han@nxp.com>
Subject: Re: [PATCH 1/3] dt-bindings: fsl: dspi: Add fsl,ls1088a-dspi
 compatible string
Message-ID: <20190821183411.GA26478@bogus>
References: <20190801083105.30102-1-chuanhua.han@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801083105.30102-1-chuanhua.han@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu,  1 Aug 2019 16:31:03 +0800, Chuanhua Han wrote:
> new compatible string: "fsl,ls1088a-dspi".
> 
> Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
