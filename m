Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7517D154D90
	for <lists+linux-spi@lfdr.de>; Thu,  6 Feb 2020 21:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgBFUz4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 6 Feb 2020 15:55:56 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:32768 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727526AbgBFUz4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 6 Feb 2020 15:55:56 -0500
Received: by mail-pl1-f194.google.com with SMTP id ay11so61533plb.0;
        Thu, 06 Feb 2020 12:55:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hRqb0rGcJmy8G6SRcQd6g+ICeu/a0h7S63LOWMjzit8=;
        b=LLpM/Ascy7JIWQ/KdWSlmQ4+4h4JSoRecD1o3zsqkQDZUGbXCvub6wrpISv8k5grP/
         GjU7CnslwBbEhMQ2We1z+3WTp7a3WU+ABveXGDKNlsffPRmAQaWZWdYh0LP2KtJc2UN/
         HJICdlNZe1WTlca1yZDVTkz/IIWf3CHEyAqaE8NOCWZtGt5olHVyW7uMy9PCVRxlcpIc
         vkt5GA7Ga9b/mxDAphGyOSRHDsUWqi2KsyxKPqtyAt6dP1Qfye2dM7cRiQxwlAK4cQX7
         DZSL1tPQp/ZMe0fxE8mo+CLg/3NAvSMuaNYIMrmxFlxCV95cBsbAx2WHzOpl7XezsJP/
         BY8g==
X-Gm-Message-State: APjAAAVXu5hmYzSwQUMz4q3LT+CbzP09JBHkcHItRpwqmcX82v+V0Q0p
        qmfCbFW9vIBfPxPIDXOOww==
X-Google-Smtp-Source: APXvYqwbwbIxptmurXEeUKWNE3CR+62iH6My7KW9TEahwWk+LI628RJ2t+DB8PDH6jbe1l1ZXWbDlQ==
X-Received: by 2002:a17:90a:a88f:: with SMTP id h15mr7053408pjq.32.1581022555858;
        Thu, 06 Feb 2020 12:55:55 -0800 (PST)
Received: from rob-hp-laptop (63-158-47-182.dia.static.qwest.net. [63.158.47.182])
        by smtp.gmail.com with ESMTPSA id m71sm11545755pje.0.2020.02.06.12.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 12:55:55 -0800 (PST)
Received: (nullmailer pid 15538 invoked by uid 1000);
        Thu, 06 Feb 2020 20:55:51 -0000
Date:   Thu, 6 Feb 2020 13:55:51 -0700
From:   Rob Herring <robh@kernel.org>
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Chuanhong Guo <gch981213@gmail.com>
Subject: Re: [PATCH v2 2/2] dt-binding: spi: add bindings for spi-ar934x
Message-ID: <20200206205551.GA15172@bogus>
References: <20200206150626.708649-1-gch981213@gmail.com>
 <20200206150626.708649-3-gch981213@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206150626.708649-3-gch981213@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu,  6 Feb 2020 23:06:26 +0800, Chuanhong Guo wrote:
> Add binding documentation for SPI controller in Qualcomm Atheros
> AR934x/QCA95xx SoCs.
> 
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> ---
> Changes since v1: none
>  .../bindings/spi/qca,ar934x-spi.yaml          | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/qca,ar934x-spi.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
Error: Documentation/devicetree/bindings/spi/qca,ar934x-spi.example.dts:20.28-29 syntax error
FATAL ERROR: Unable to parse input tree
scripts/Makefile.lib:300: recipe for target 'Documentation/devicetree/bindings/spi/qca,ar934x-spi.example.dt.yaml' failed
make[1]: *** [Documentation/devicetree/bindings/spi/qca,ar934x-spi.example.dt.yaml] Error 1
Makefile:1263: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1234394
Please check and re-submit.
