Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE15F4C1A81
	for <lists+linux-spi@lfdr.de>; Wed, 23 Feb 2022 19:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240281AbiBWSDI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 23 Feb 2022 13:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236327AbiBWSDG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 23 Feb 2022 13:03:06 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107AC35856;
        Wed, 23 Feb 2022 10:02:39 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id s14so28112196edw.0;
        Wed, 23 Feb 2022 10:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=6/CbbKb963ZeCrGB3DpHf3S/LmT0OSOkIfiP6ix0yNw=;
        b=ja7eWC8yM81uxKYq1CCj7+E+5nx65m6I8TNqx8d1RSupI8Vu0xgsD4tbMjzlLJwNhq
         vGNC6G8/8yNSBTQ3ffia3tNjLQ6zCcl5cl7vLEcJs7zvEiOsLWMHIX8hcj6fVysJ9YpC
         LjwEe9AbpSRZWE9Z71vkOPl7H/KlZUg7SoF0biFC3edx50WUsiwAj2mDgPQNMHJzyZcx
         da5dUsscp3Twr3zXlsZMp7pFexSsch0gIKY1bubBIdQp/1fyNhQbj0JK3Hz5DuaAtry4
         2G8QoaDP2RvOcxtBor7mFfgycQcWMDYCSljvCaUgsPc7N0MK7c5/er+2Soq+kPplpYSB
         ppmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=6/CbbKb963ZeCrGB3DpHf3S/LmT0OSOkIfiP6ix0yNw=;
        b=JNGpKqmim9PJH+fPeNdzgkZycHCKem2yCnmFmpfZjE/wI5lRqV/1d9L2oOHwlAj9oa
         u9SN4eEdP57Supc8vpQnfZbKzfRl+lPUFlTs5EF+IjzVdYpVBm3Pe21aQv3lJudKGKDh
         m61Ry5MfDQxvIC0xqp6oJBXU5UM4y+fHAvMJh0yQxzqx9PLXhXVEDJbJfAWWncOz/WwJ
         2E0RbEGQnruPItzlhqB79fFy5jSu3eekRcvVloKsKtlb4rJNJYxDUdzJtMzC19uj29rN
         y5pzWjy9UAwWi4RIU+FR9Qr3rXaghsjPhdM/NIWE6iO0eE1GnvjDw+8ulFSi7HWMH/Fa
         K9Eg==
X-Gm-Message-State: AOAM532K8WVoMw9xTjJPS+OzYqy9G41X0f0ZGc5Ju7QdiI39eNpKTnYn
        djMwSVZ7F7LJ9UBWbTumiy8=
X-Google-Smtp-Source: ABdhPJxIxkN5KO0RrQP8fJuziJbk305Fhl7odZ4cFGCqWDzoQmWYzPbvl+qns8Vw3cc46SN25FRaoA==
X-Received: by 2002:a05:6402:3485:b0:40d:e8eb:1dc1 with SMTP id v5-20020a056402348500b0040de8eb1dc1mr602087edc.424.1645639357148;
        Wed, 23 Feb 2022 10:02:37 -0800 (PST)
Received: from ?IPV6:2003:ea:8f4d:2b00:d12c:c0a:f603:b44d? (p200300ea8f4d2b00d12c0c0af603b44d.dip0.t-ipconnect.de. [2003:ea:8f4d:2b00:d12c:c0a:f603:b44d])
        by smtp.googlemail.com with ESMTPSA id n2sm170707ejl.55.2022.02.23.10.02.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 10:02:36 -0800 (PST)
Message-ID: <87fc1755-4047-2bcc-56cb-8e1d1cc66f7f@gmail.com>
Date:   Wed, 23 Feb 2022 19:00:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: [PATCH v3 3/5] docs: ABI: document tm1628 attribute display-text
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Miguel Ojeda <ojeda@kernel.org>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
References: <4eb7b036-a9b9-3bd2-4e84-f56ba4b1a740@gmail.com>
In-Reply-To: <4eb7b036-a9b9-3bd2-4e84-f56ba4b1a740@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Document the attribute for reading / writing the text to be displayed on
the 7 segment display.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 Documentation/ABI/testing/sysfs-devices-auxdisplay-tm1628 | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-auxdisplay-tm1628

diff --git a/Documentation/ABI/testing/sysfs-devices-auxdisplay-tm1628 b/Documentation/ABI/testing/sysfs-devices-auxdisplay-tm1628
new file mode 100644
index 000000000..382757e72
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-auxdisplay-tm1628
@@ -0,0 +1,7 @@
+What:		/sys/devices/.../display-text
+Date:		February 2022
+Contact:	Heiner Kallweit <hkallweit1@gmail.com>
+Description:
+		The text to be displayed on the 7 segment display.
+		Any printable character is allowed as input, but some
+		can not be displayed in a readable way with 7 segments.
-- 
2.35.1


