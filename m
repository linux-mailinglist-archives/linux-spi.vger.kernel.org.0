Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872D02D99BD
	for <lists+linux-spi@lfdr.de>; Mon, 14 Dec 2020 15:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440073AbgLNOVi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Dec 2020 09:21:38 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39612 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440075AbgLNOVg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 14 Dec 2020 09:21:36 -0500
Received: by mail-ot1-f66.google.com with SMTP id d8so15830847otq.6;
        Mon, 14 Dec 2020 06:21:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bMgE1mV+D84ls7Dep4laRCdXMSux3/HyOQ9lsiQUOHM=;
        b=RcXQcQ4eZqksuhc5oE4fdr7Q9h7H+hWHIM90e2MnURnlmShLmDg5ZGYDyN//KNaPCV
         UVccDotSKEFllC8d9MnmPn+xWOFvb4cYLJwTR+pVq6pt1v1FiQsi0vQlDPkPsaGTAveN
         JmH5VrKfySrU75qUnk6+K624pMuxYX8Uj8LEu1N/MNiRO2s/h2/z8pzJr4Fpeg+kOX6M
         WmmgBiSvKRe8LOjhdqNHV/w1VQQYRj9Ht0/lwRmbjpfdufHAUpBQExdkkwGUTNhApg8I
         RZpyc9m41fypRG+QQRKW3jojPSIAD6lmOuX9ASr8DaPPu0v4jynuAhW5qK2HnZQWuMga
         BckQ==
X-Gm-Message-State: AOAM533d4hpagIwuu2l9VjbzEyiK6Se7xbqh8gQNrGvk07SxeXZRcGuH
        xIZmntyFe0b6zN+8GNDhIA==
X-Google-Smtp-Source: ABdhPJym+56a5b01xOe6vNW8dPKK6TXt7fv9TQK1/yLBNmbfiGcbyYLA7f+sxD5zoNw53DKH1xbsmA==
X-Received: by 2002:a9d:2065:: with SMTP id n92mr19449009ota.150.1607955654943;
        Mon, 14 Dec 2020 06:20:54 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e10sm4336466otl.38.2020.12.14.06.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 06:20:54 -0800 (PST)
Received: (nullmailer pid 1864046 invoked by uid 1000);
        Mon, 14 Dec 2020 14:20:53 -0000
Date:   Mon, 14 Dec 2020 08:20:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Huacai Chen <chenhc@lemote.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/4] spi: ls7a: Add YAML schemas
Message-ID: <20201214142053.GA1863733@robh.at.kernel.org>
References: <1607925534-8312-1-git-send-email-zhangqing@loongson.cn>
 <1607925534-8312-2-git-send-email-zhangqing@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607925534-8312-2-git-send-email-zhangqing@loongson.cn>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 14 Dec 2020 13:58:52 +0800, Qing Zhang wrote:
> Switch the DT binding to a YAML schema to enable the DT validation.
> 
> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
> ---
>  .../devicetree/bindings/spi/loongson,spi-ls7a.yaml | 49 ++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/loongson,spi-ls7a.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/spi/loongson,spi-ls7a.yaml:10:4: [warning] wrong indentation: expected 2 but found 3 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/loongson,spi-ls7a.yaml: Additional properties are not allowed ('all0f' was unexpected)
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/loongson,spi-ls7a.yaml: 'additionalProperties' is a required property
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/loongson,spi-ls7a.yaml: Additional properties are not allowed ('all0f' was unexpected)
./Documentation/devicetree/bindings/spi/loongson,spi-ls7a.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/spi/loongson,spi-ls7a.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/loongson,spi-ls7a.yaml: ignoring, error in schema: 
warning: no schema found in file: ./Documentation/devicetree/bindings/spi/loongson,spi-ls7a.yaml
Documentation/devicetree/bindings/spi/loongson,spi-ls7a.example.dts:25.13-44: Warning (reg_format): /example-0/spi@16,0:reg: property has invalid length (20 bytes) (#address-cells == 1, #size-cells == 1)
Documentation/devicetree/bindings/spi/loongson,spi-ls7a.example.dt.yaml: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/spi/loongson,spi-ls7a.example.dt.yaml: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/spi/loongson,spi-ls7a.example.dt.yaml: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/spi/loongson,spi-ls7a.example.dt.yaml: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/spi/loongson,spi-ls7a.example.dt.yaml: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/loongson,spi-ls7a.example.dt.yaml: example-0: spi@16,0:reg:0: [45056, 0, 0, 0, 0] is too long
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml


See https://patchwork.ozlabs.org/patch/1415811

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

