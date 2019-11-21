Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDB681054A4
	for <lists+linux-spi@lfdr.de>; Thu, 21 Nov 2019 15:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfKUOi6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 Nov 2019 09:38:58 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44790 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfKUOi5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 21 Nov 2019 09:38:57 -0500
Received: by mail-ot1-f67.google.com with SMTP id c19so3066435otr.11;
        Thu, 21 Nov 2019 06:38:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0blBAL3wZkz50HycghqiK2pciwvxeqAeMTt/kJRNm5g=;
        b=qbz3JTU/Fm0TUnxowGxCiuSAU+NDoYoSMxXGSD1+YybXUE1vLhZ0EMZY+Fe0UXUuvw
         UWj8Z/lBY20URlXdRcXUXC2C0GYxDsGOf8EPpVKBXtl8ZSefVC9uq3PuKLjvgyL88SEe
         0Q1LZea0QZ+67AjozVVQf++mpE9AUmtyz4IL5IdAoWmFjl08BsZY90kGVOgQvgUxLUw5
         +1HdfoeKCJ0Rv3PwTg2AVtNrXCkJrPuU8NRS9exfjscZrGv+VA6RISiso52A0c6L3Bcj
         x3tuQ2t4S8i6Pa4Bj33RGmQSQuyuZ3WOFaT5L60pSw3lkywBaXwJKOK4OzKQGYHlt8fd
         bt3A==
X-Gm-Message-State: APjAAAUrKxCNHgnIthpSGJM4OUuJJtKsVhxvJnYuwovplVkxY/J9qWNL
        qx5WkW0qIphwVg5Ya7eF6JgxO/0=
X-Google-Smtp-Source: APXvYqwnaGGSvHw3eVxDSnMv1fQxO7SKEamfp9zxy8HwVAD1LSiD/kDoELucP/RnyFz5AWlq8jVXBQ==
X-Received: by 2002:a9d:7a93:: with SMTP id l19mr6448599otn.314.1574347136596;
        Thu, 21 Nov 2019 06:38:56 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h39sm1055423oth.9.2019.11.21.06.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 06:38:56 -0800 (PST)
Date:   Thu, 21 Nov 2019 08:38:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        alexandre.torgue@st.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH v2] dt-bindings: spi: Convert stm32 QSPI bindings to
 json-schema
Message-ID: <20191121143855.GA23685@bogus>
References: <20191120194444.10540-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120194444.10540-1-benjamin.gaignard@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 20 Nov 2019 20:44:44 +0100, Benjamin Gaignard wrote:
> Convert the STM32 QSPI binding to DT schema format using json-schema
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
> changes in version 2:
> - fix subject
> - remove useless minItems and maxItems
>  .../devicetree/bindings/spi/spi-stm32-qspi.txt     | 47 ------------
>  .../devicetree/bindings/spi/st,stm32-qspi.yaml     | 83 ++++++++++++++++++++++
>  2 files changed, 83 insertions(+), 47 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-stm32-qspi.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/st,stm32-qspi.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
