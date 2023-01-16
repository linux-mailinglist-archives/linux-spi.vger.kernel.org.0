Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7440866C974
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jan 2023 17:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbjAPQtz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Jan 2023 11:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233888AbjAPQte (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Jan 2023 11:49:34 -0500
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4828D30B39;
        Mon, 16 Jan 2023 08:36:20 -0800 (PST)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1322d768ba7so29331408fac.5;
        Mon, 16 Jan 2023 08:36:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SFr5MST759iCxbMXzvw187XGNmIGHm5FuB+MhlAMlT0=;
        b=ijB9SxhCuK1lZewckLVtPzsf2MAi7pLSXgC84i6xXljk0zPQ1TAryk2u62LB3eL02Z
         VR8u/gCZrrJCdJ8zFeSKsSK46kHyPcPPgnj+UJeUc+sz9apbSpcXtRllhxdvfuDuyRyz
         Fx46E7IpZMYmtZyJEPDH+zuIOoxcD31YaynKSUckhdOhagE8Tu7dSxdw9AcHjH/n1CQL
         fKoGtKNu8Ba0s6eiI6oZCrWEz7BGIMpIZ9hY0dRuh7y1qgbb9GOwURl2xbKpe4KhXa8J
         szVJmtJAVMSKARcDwMqNvpZhDvk5sII2jDRU254kzK2fdKTHc5XlX55WXgRkcnqa4pKx
         TzeA==
X-Gm-Message-State: AFqh2koycv9xIA3rWXn9pra85gdL5XvWVwm0UB5vppN4BAwTL2LdzVTT
        U4SmJn/newukqf5ZdR7flkWIcqEiOg==
X-Google-Smtp-Source: AMrXdXuguaLABLkXFaVusNPUcOu6Nz45Ir0Cih+LwTX5aK7LRAWMS4Mc8tIf0Go0SjCBW7JGldA1fg==
X-Received: by 2002:a05:6871:450a:b0:15e:d859:9d22 with SMTP id nj10-20020a056871450a00b0015ed8599d22mr141852oab.57.1673886980057;
        Mon, 16 Jan 2023 08:36:20 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f15-20020a056870548f00b0015f1024d322sm3327505oan.37.2023.01.16.08.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 08:36:19 -0800 (PST)
Received: (nullmailer pid 606188 invoked by uid 1000);
        Mon, 16 Jan 2023 16:36:12 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Mario Kicherer <dev@kicherer.org>
Cc:     krzysztof.kozlowski+dt@linaro.org, broonie@kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, han.xu@nxp.com,
        linux-spi@vger.kernel.org
In-Reply-To: <20230116115050.2983406-2-dev@kicherer.org>
References: <20230116115050.2983406-1-dev@kicherer.org>
 <20230116115050.2983406-2-dev@kicherer.org>
Message-Id: <167388664128.594222.10848422541616513414.robh@kernel.org>
Subject: Re: [PATCH 1/2] spi: dt-bindings: spi-fsl-qspi: add optional sampling-delay
Date:   Mon, 16 Jan 2023 10:36:12 -0600
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On Mon, 16 Jan 2023 12:50:49 +0100, Mario Kicherer wrote:
> Add optional sampling-delay property to delay the internal sampling point for
> incoming data.
> 
> Signed-off-by: Mario Kicherer <dev@kicherer.org>
> ---
>  Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml: properties:fsl,qspi-sampling-delay: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('default', 'maximum', 'minimum' were unexpected)
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml: properties:fsl,qspi-sampling-delay: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml: properties:fsl,qspi-sampling-delay: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230116115050.2983406-2-dev@kicherer.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

