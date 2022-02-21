Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB174BE39F
	for <lists+linux-spi@lfdr.de>; Mon, 21 Feb 2022 18:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357520AbiBUQ05 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Feb 2022 11:26:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380566AbiBUQZu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Feb 2022 11:25:50 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C212AC58;
        Mon, 21 Feb 2022 08:24:08 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id lw4so34600519ejb.12;
        Mon, 21 Feb 2022 08:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ArCK5lfgeHCHqGrG/JTjDF+ImUnw3K5a8jgMNQx5ZO8=;
        b=nUlTyTRuCnE1xlzGTdnDHz0m1VmaqizYIvggf4+N8gDuWOQngffRjVw6u0kGWOLiyt
         555yvIvPxWokh/Uu8di5ElbbSYFylotdvpIU3JBSFl3eEVq9JYSkiuXlvDr5Egk8iOmw
         Ln4aLWr23Nbj2oyvhgaYZ9Nal88+IW3FP0rgqb5lccLKy4AWnLcn6BfKgxcZP92+O5OV
         5ChDJVL1/vjeN4VPVVZvleltjVnOktuxqg1TQCkA+0rDauRBpyh7IIfNmZ+vdwtL82sL
         jXG4bMBnQqbw9ObwhilB+htP1wXhuyEbVUJ6QBTd63hYn7fW5uNJnYwM7fRf5+F31QyN
         JtBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ArCK5lfgeHCHqGrG/JTjDF+ImUnw3K5a8jgMNQx5ZO8=;
        b=EqOF6SIwG5s1g2yvyHMWiF4Qz847MqDR7XDENvW/HeEAFlWIYnaHo+HrLBW5cRK7nr
         uZI7tYxyC2jOwE9Zv+Umdpj5wFLzgTfyJoal+60E5zu29Tvsjt6nNpJAyaaaUKhY53zO
         e1oCc64S+/YG3m1CpMDzpJ3FCddPh9HIK1dvZ1oK4Ss4BPPKh9QVyE4koTb5Q8FgbMjl
         VTCLMsAQUeags+w2jXle9WrssKtIayil+LthDsAPa06dyurolhxeSj9K7iSEbzPpaUiX
         3OQ1QeIbGROW8kKY/+amqBllYxIosLyV0s4TqhwG2eHTkF/giyk1u63y0GPALPw/0rUb
         TQEQ==
X-Gm-Message-State: AOAM5303RUnKug8ql4JxZqqlstmN89wDWPObKlcZBCCxpfPn44eEVGJt
        lAZwvqoHz7AhVHISd952lt0=
X-Google-Smtp-Source: ABdhPJzQu4/qIsGzgNkul+LsenCqmNDHAJm/pm+E3OEy8JfIuSB8yb+R9jRSxIjuJKk6wrdvoW7G2Q==
X-Received: by 2002:a17:907:7349:b0:6d0:91b2:c74a with SMTP id dq9-20020a170907734900b006d091b2c74amr13523094ejc.679.1645460647295;
        Mon, 21 Feb 2022 08:24:07 -0800 (PST)
Received: from ?IPV6:2003:ea:8f4d:2b00:a926:13e5:7f67:226? (p200300ea8f4d2b00a92613e57f670226.dip0.t-ipconnect.de. [2003:ea:8f4d:2b00:a926:13e5:7f67:226])
        by smtp.googlemail.com with ESMTPSA id bo11sm5267912ejb.24.2022.02.21.08.24.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 08:24:06 -0800 (PST)
Message-ID: <383cdece-660d-4ced-920d-5661941e6c1d@gmail.com>
Date:   Mon, 21 Feb 2022 17:23:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 3/6] dt-bindings: auxdisplay: Add Titan Micro Electronics
 TM1628
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
References: <4172e59f-b9d5-d87d-9dbd-a6f683a2173c@gmail.com>
 <d8fff247-d3ce-79f0-6d0b-dcce44457681@gmail.com>
 <1645410969.379359.2041544.nullmailer@robh.at.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <1645410969.379359.2041544.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 21.02.2022 03:36, Rob Herring wrote:
> On Sat, 19 Feb 2022 14:17:54 +0100, Heiner Kallweit wrote:
>> Add a YAML schema binding for TM1628 auxdisplay
>> (7/11-segment LED) controller.
>>
>> This patch is partially based on previous RFC work from
>> Andreas Färber <afaerber@suse.de>.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  .../bindings/auxdisplay/titanmec,tm1628.yaml  | 82 +++++++++++++++++++
>>  1 file changed, 82 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml:12:5: [warning] wrong indentation: expected 6 but found 4 (indentation)
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml: 'maintainers' is a required property
> 	hint: Metaschema for devicetree binding documentation
> 	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml: 'additionalProperties' is a required property
> 	hint: A schema without a "$ref" to another schema must define all properties and use "additionalProperties"
> 	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
> ./Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml: $id: relative path/filename doesn't match actual path or filename
> 	expected: http://devicetree.org/schemas/auxdisplay/titanmec,tm1628.yaml#
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.yaml: ignoring, error in schema: 
> Documentation/devicetree/bindings/auxdisplay/titanmec,tm1628.example.dt.yaml:0:0: /example-0/spi/led-controller@0: failed to match any schema with compatible: ['titanmec,tm1628']
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/patch/1595016
> 
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.
> 
Thanks for the feedback. Will check and consider it in v2.
