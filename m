Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D27C7E03C0
	for <lists+linux-spi@lfdr.de>; Fri,  3 Nov 2023 14:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbjKCN32 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Nov 2023 09:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjKCN31 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Nov 2023 09:29:27 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBD211B
        for <linux-spi@vger.kernel.org>; Fri,  3 Nov 2023 06:29:24 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-41e58a33ec9so11078091cf.1
        for <linux-spi@vger.kernel.org>; Fri, 03 Nov 2023 06:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1699018164; x=1699622964; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f5hQXxQSZxO3OZcCJDZkPQHyyuV8tvUWsRYcmXkePgE=;
        b=1QTz2NOuMb1GC999v0VIP/ms1+ewVvw8xJSWBTX+BNW5YCmjVPrnEJbcfFOHuoc/i9
         7zt4rHuTxk+A4q2Tnjh0i54oVTg+qjhfKRSPLjktiKP1N48/gL3uOVtQNOOU0HzCo+op
         N2673Gdfri+agbHMg1afdfAnJoCzWqJw91ISlbbTKb/BVCO5x7yxVRCvV87mh4gfxzkK
         LjryHTCPHbMXuVykUqxd24u5Vjq9XcjKiRj+d1CzdABAr9cUYPQQewJKtRxLdG3PS8Kg
         IDXRorZJ/iXuyrRNXaykP45r7El/3TlsBAlOo6yhOjkGrTOaHiHUw5UobXGOqSTTei0u
         Mnyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699018164; x=1699622964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f5hQXxQSZxO3OZcCJDZkPQHyyuV8tvUWsRYcmXkePgE=;
        b=emE6rw3cLWsgBuW0bIczkKu1T8KJc2lOrtnZQ3H4JZmlMpI1iWbu6bKyVhiucg0djA
         RLF3qin9OkDlK4c1hKtMwqdlCOR13woBwMfum0M0g6rQ6ebBC6eBlT9psleloNwACJyP
         n8EeWiTBCghI9J5xmv/qYIgnMuayFnQbRmuNR393gYUK0rvvugbpUoHzyuiD2AIpDOo7
         8bc7DF2Y4yaL/QH4iQAZ6nMcgH9fAFvTlm/vfUMhH3ym62SgvtT+Ijdd5ZkJlsaKkduu
         bNW0Q3+Av+IQipNpJJbc4fH6Hnng4/NZoGbAWIM4MqVGgLxWhqWOtX/cjjFlA09St52u
         PyRw==
X-Gm-Message-State: AOJu0YyhvYHS85EK28jz2711EWT1nAfC8/8YMtfUJa+UtCJEC0ZlKyBg
        Vmyl8akCgG/cMS8RWbhy7wc5lg==
X-Google-Smtp-Source: AGHT+IEn5wRuUs2lNs9myO4AF2zBH6YUvvrm/OBfPI7RX6oZHVthZK736BXDD9Z+YCw0VljCX13Q1Q==
X-Received: by 2002:ac8:5b89:0:b0:417:b901:91a7 with SMTP id a9-20020ac85b89000000b00417b90191a7mr27765637qta.24.1699018164054;
        Fri, 03 Nov 2023 06:29:24 -0700 (PDT)
Received: from dell-precision-5540 ([50.212.55.89])
        by smtp.gmail.com with ESMTPSA id gb7-20020a05622a598700b00418189b689csm723217qtb.10.2023.11.03.06.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 06:29:23 -0700 (PDT)
Date:   Fri, 3 Nov 2023 09:29:12 -0400
From:   Ben Wolsieffer <ben.wolsieffer@hefring.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Erwan Leray <erwan.leray@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: Re: [PATCH v2 3/5] dt-bindings: spi: add stm32f7-spi compatible
Message-ID: <ZUT1qFieeCby9ALg@dell-precision-5540>
References: <20231102193722.3042245-1-ben.wolsieffer@hefring.com>
 <20231102193722.3042245-4-ben.wolsieffer@hefring.com>
 <20231103-recognize-unwashed-b8f1a83fe851@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103-recognize-unwashed-b8f1a83fe851@spud>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Conor,

On Fri, Nov 03, 2023 at 12:50:53PM +0000, Conor Dooley wrote:
> On Thu, Nov 02, 2023 at 03:37:20PM -0400, Ben Wolsieffer wrote:
> A wider range of supported word sizes and some additional buffers,
> implies that the F4 could be used as a fallback compatible. Does the
> register map change incompatibly in the process of widening the FIFOs or
> something like that?

Yes, the F4 has a single bit to select 8 or 16 bit word size, while the
F7 uses four bits to select an arbitrary word size from 4 to 16 bits.
This series supports the packing mode, to allow sending two <=8 bit
words with a single write to the FIFO, but even if we didn't want to
support this feature, the F7 would require setting the FRXTH bit (not
present in the F4) when using <=8 bit word sizes.

> 
> Cheers,
> Conor.


