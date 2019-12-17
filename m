Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA347123B2C
	for <lists+linux-spi@lfdr.de>; Wed, 18 Dec 2019 00:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbfLQX5j (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Dec 2019 18:57:39 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33235 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfLQX5i (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 17 Dec 2019 18:57:38 -0500
Received: by mail-ot1-f66.google.com with SMTP id b18so115739otp.0;
        Tue, 17 Dec 2019 15:57:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E/Jh0gEjrB4l4YoPQEAqdMSsYPuhulVXEcBxp+hlji8=;
        b=UMU0Ead/Cxco7nOOQalTKmVG2LoInDYvBgleOGNAhW3VJrW8xvDnLdzjXfOustMvFm
         tIqtTNY5V3Ln1QP2g8mNesKnQjWecev3DYZw56XWJaSeF2fCrnX+EImK7oCud4mgoW4g
         oekfzdU1qylV8WEW4NELWmyq2ycHSjKEJhQK4obYR49+1+v38rUjk4ZkSX1+ABwCFyWO
         CAP1acMqETkCKMepp+JaSNuCIqbEOl11RhyOrOnBFf615ayjemh8BejvS/BFMqq4bynw
         QFDdEfqkjtwLkLzrOgK0czKIjzQfuLVk984TJIW+Q47eG1WCk4nQ6iFg3rh8KyOAUznb
         gULw==
X-Gm-Message-State: APjAAAVmndX1FMgEhQ6YbRMYAtBWqRmuHRHvrDGm9SvNyRMekdUSpLwq
        6QQyAClj54Dg16vO6AGoZg==
X-Google-Smtp-Source: APXvYqzmn8JDS5mvDHSpuGCBOrZ4cPvFj6ziPOM02alJJJusCEI9xOeuXQl0jITxSGcWJaouCznyQA==
X-Received: by 2002:a05:6830:1bf2:: with SMTP id k18mr128163otb.36.1576627057677;
        Tue, 17 Dec 2019 15:57:37 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e21sm169865oib.16.2019.12.17.15.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 15:57:37 -0800 (PST)
Date:   Tue, 17 Dec 2019 17:57:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        alexandre.torgue@st.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Erwan Leray <erwan.leray@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: Re: [PATCH v2] dt-bindings: spi: Convert stm32 spi bindings to
 json-schema
Message-ID: <20191217235736.GA17096@bogus>
References: <20191217090715.13334-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217090715.13334-1-benjamin.gaignard@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 17 Dec 2019 10:07:15 +0100, Benjamin Gaignard wrote:
> Convert the STM32 spi binding to DT schema format using json-schema
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> CC: Erwan Leray <erwan.leray@st.com>
> CC: Fabrice Gasnier <fabrice.gasnier@st.com>
> CC: Amelie Delaunay <amelie.delaunay@st.com>
> ---
> changes in version 2:
> - fix typo in if block (compatible + contains)
>   The boths typos weren't detected by checkpatch.
> - remove type for st,spi-midi-ns property but not add upper limit
>   because the driver compute a delay (expressed in SPI clock cycles periods)
>   from this value (expressed in nanoseconds) and all that depends of the SPI
>   bus clock.
>  .../devicetree/bindings/spi/spi-stm32.txt          |  62 ------------
>  .../devicetree/bindings/spi/st,stm32-spi.yaml      | 105 +++++++++++++++++++++
>  2 files changed, 105 insertions(+), 62 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-stm32.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
